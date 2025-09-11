from uuid import UUID
from fastapi import Query
from sqlmodel import or_, select
from .base_crud import CRUDBase
from app.models import TblUserType
from sqlmodel.ext.asyncio.session import AsyncSession
from app.schemas.user_type_schema import UserTypeCreate, UserTypeUpdate


class CRUDUserType(CRUDBase[TblUserType, UserTypeCreate, UserTypeUpdate]):
    async def get_all(
        self,
        *,
        is_active: bool | None = Query(None),
        keyword: str = Query(""),
        db_session: AsyncSession | None = None,
    ) -> list[TblUserType]:
        db_session = db_session or super().get_db().session
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.code.ilike(f"%{keyword}%"),
                ),
                or_(is_active == None, self.model.is_active.is_(is_active)),
            )
            .order_by(self.model.code)
        )
        response = await db_session.execute(query)
        return response.scalars().all()

    async def update_by_code(
        self,
        *,
        bank_code: str,
        obj_in: UserTypeUpdate,
        updated_by_id: UUID | str | None = None,
        db_session: AsyncSession | None = None,
    ) -> list[TblUserType]:
        db_session = db_session or super().get_db().session
        bank_obj = await self.get_by_code(code=bank_code, db_session=db_session)
        return await self.update(
            obj_current=bank_obj,
            obj_new=obj_in,
            db_session=db_session,
            updated_by_id=updated_by_id,
        )


bank = CRUDUserType(TblUserType)
