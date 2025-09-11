from collections.abc import AsyncGenerator
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from app.models.user_model import TblUser
from pydantic import ValidationError
from app import crud
from app.core import security
from app.core.config import settings
from app.db.session import SessionLocal
from sqlmodel.ext.asyncio.session import AsyncSession
from app.schemas.token_schema import TokenPayload


reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"{settings.API_V1_STR}/login/access-token"
)


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with SessionLocal() as session:
        yield session


def get_current_user(
    *,
    objtype_code: str | None = None,
    auth: list[str] | None = [],
) -> TblUser:
    async def current_user(token: str = Depends(reusable_oauth2)) -> TblUser:
        try:
            payload = jwt.decode(
                token, settings.SECRET_KEY, algorithms=[security.ALGORITHM]
            )
            token_data = TokenPayload(**payload)
        except (jwt.JWTError, ValidationError):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials",
            )
        user_id = token_data.sub
        user: TblUser = await crud.user.get(id=user_id)
        if not user:
            raise HTTPException(status_code=401, detail="User not found")
        if not user.is_active:
            raise HTTPException(status_code=401, detail="Inactive user")
        if user.is_superuser:
            return user
        if objtype_code:
            if objtype_code == "MSTR":
                if not (user.is_admin or user.is_superuser):
                    raise HTTPException(status_code=401, detail="Unauthorized! user!")
            else:
                if not (user.is_admin or user.is_superuser):
                    obj_auth = await crud.auth_obj.get_by_user_and_obj(
                        user_id=user_id, objtype_code=objtype_code
                    )
                    if not obj_auth.auth in auth:
                        raise HTTPException(status_code=401, detail="Unauthorize user!")
        return user

    return current_user


def get_admin_user() -> TblUser:
    async def current_user(token: str = Depends(reusable_oauth2)) -> TblUser:
        try:
            payload = jwt.decode(
                token, settings.SECRET_KEY, algorithms=[security.ALGORITHM]
            )
            token_data = TokenPayload(**payload)
        except (jwt.JWTError, ValidationError):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials",
            )
        user_id = token_data.sub
        user: TblUser = await crud.user.get(id=user_id)
        if not user:
            raise HTTPException(status_code=401, detail="User not found")
        if not user.is_active:
            raise HTTPException(status_code=401, detail="Inactive user")

        if not (user.is_admin or user.is_superuser):
            raise HTTPException(status_code=401, detail="Unauthorized! user!")
        return user

    return current_user
