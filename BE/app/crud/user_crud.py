from datetime import datetime
from fastapi.encoders import jsonable_encoder
from fastapi_pagination import Page, Params
from sqlalchemy import or_, exc
from app.schemas.user_schema import UserCreate, UserUpdate
from app.models.user_model import TblUser
from app.core.security import verify_password, get_password_hash
from typing import Any
from app.crud.base_crud import CRUDBase
from sqlmodel import select
from fastapi import HTTPException, Query
from uuid import UUID
from sqlmodel.ext.asyncio.session import AsyncSession
from app import crud


class CRUDUser(CRUDBase[TblUser, UserCreate, UserUpdate]):
    async def get_by_email(
        self, *, email: str, db_session: AsyncSession | None = None
    ) -> TblUser | None:
        db_session = db_session or super().get_db().session
        users = await db_session.execute(select(TblUser).where(TblUser.email == email))
        return users.scalar_one_or_none()

    async def get_by_id_active(self, *, id: UUID) -> TblUser | None:
        user = await super().get(id=id)
        if not user:
            return None
        if user.is_active == False:
            return None

        return user

    async def get_all_not_paginated(
        self,
        *,
        keyword: str = "",
        db_session: AsyncSession | None = None,
    ) -> list[TblUser]:
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.email.ilike(f"%{keyword}%"),
                    self.model.fullname.ilike(f"%{keyword}%"),
                ),
            )
            .order_by(self.model.email)
        )
        query_result = await db_session.execute(query)
        data = query_result.scalars().all()
        return data

    async def get_all_paginated(
        self,
        *,
        params: Params | None,
        keyword: str = "",
        db_session: AsyncSession | None = None,
    ) -> Page[TblUser]:
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.email.ilike(f"%{keyword}%"),
                    self.model.fullname.ilike(f"%{keyword}%"),
                ),
            )
            .order_by(self.model.email)
        )
        return await self.get_multi_paginated(params=params, query=query)

    async def create_with_role(
        self,
        *,
        obj_in: UserCreate,
        db_session: AsyncSession | None = None,
    ) -> TblUser:
        db_session = db_session or super().get_db().session
        user_obj = TblUser.from_orm(obj_in)
        user_obj.hashed_password = get_password_hash(obj_in.password)

        db_session.add(user_obj)
        await db_session.commit()
        await db_session.refresh(user_obj)
        return user_obj

    async def update_is_active(
        self, *, db_obj: list[TblUser], obj_in: int | str | dict[str, Any]
    ) -> TblUser | None:
        response = None
        db_session = super().get_db().session
        for x in db_obj:
            x.is_active = obj_in.is_active
            db_session.add(x)
            await db_session.commit()
            await db_session.refresh(x)
            response.append(x)
        return response

    async def update_by_user_id(
        self,
        *,
        obj_new: UserUpdate | dict[str, Any],
        user_id: UUID | str | None = None,
        updated_by: UUID | None = None,
    ) -> TblUser | None:
        try:
            db_session = super().get_db().session
            obj_current = await self.get(id=user_id, db_session=db_session)
            obj_data = jsonable_encoder(obj_current)

            if isinstance(obj_new, dict):
                update_data = obj_new
            else:
                update_data = obj_new.dict(
                    exclude_unset=True
                )  # This tells Pydantic to not include the values that were not sent

            if "password" in update_data:
                password = update_data.pop("password")
                update_data["hashed_password"] = get_password_hash(password)

            for field in obj_data:
                if field == "id":
                    continue
                elif field in update_data:
                    if getattr(obj_current, field) != update_data[field]:  # ch
                        setattr(obj_current, field, update_data[field])

            if updated_by:
                obj_current.updated_by = updated_by
                obj_current.updated_at = datetime.now()

            db_session.add(obj_current)
            await db_session.commit()
            await db_session.refresh(obj_current)
            return obj_current

        except exc.IntegrityError as err:
            await db_session.rollback()

            raise HTTPException(
                status_code=409,
                detail=str(err),
            )
        except exc.SQLAlchemyError as err:
            await db_session.rollback()
            raise HTTPException(
                status_code=409,
                detail="SQLAlchemyError: {err}".format(err=err),
            )

    async def authenticate(self, *, email: str, password: str) -> TblUser | None:
        user = await self.get_by_email(email=email)
        if not user:
            return None
        if not verify_password(password, user.hashed_password):
            return None
        return user

    # async def change_password(
    #     self,
    #     *,
    #     user_id: UUID,
    #     obj_in: IUserChangePassword,
    #     db_session: AsyncSession | None = None,
    # ) -> TblUser:
    #     db_session = db_session or super().get_db().session
    #     db_obj: TblUser = await self.get(id=user_id, db_session=db_session)
    #     if not db_obj:
    #         raise HTTPException(status_code=404, detail="Invalid uuid")
    #     db_obj.hashed_password = get_password_hash(obj_in.password)
    #     await db_session.commit()
    #     await db_session.refresh(db_obj)
    #     return db_obj

    async def remove(
        self, *, id: UUID | str, db_session: AsyncSession | None = None
    ) -> TblUser:
        db_session = db_session or super().get_db().session
        response = await db_session.execute(
            select(self.model).where(self.model.id == id)
        )
        obj = response.scalar_one()

        await db_session.delete(obj)
        await db_session.commit()
        return obj


user = CRUDUser(TblUser)
