from app import crud
from app.models.user_model import TblUser
from app.schemas.user_schema import UserCreate, UserRead
from app.utils.exceptions.common_exception import IdNotFoundException
from uuid import UUID
from fastapi import HTTPException, Path, status
from typing_extensions import Annotated


async def user_exists(new_user: UserCreate) -> UserCreate:
    user = await crud.user.get_by_email(email=new_user.email)
    if user:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="There is already a user with same email",
        )
    return new_user


async def is_valid_user(
    user_id: Annotated[UUID, Path(title="The UUID id of the user")],
) -> UserRead:
    user = await crud.user.get(id=user_id)
    if not user:
        raise IdNotFoundException(TblUser, id=user_id)

    return user


async def is_valid_user_id(
    user_id: Annotated[UUID, Path(title="The UUID id of the user")],
) -> UserRead:
    user = await crud.user.get(id=user_id)
    if not user:
        raise IdNotFoundException(TblUser, id=user_id)

    return user_id
