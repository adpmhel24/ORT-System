from datetime import datetime
from uuid import UUID
from fastapi import Query
from sqlmodel import or_, select
from .base_crud import CRUDBase
from app.models import TblBusinessPartner, TblBpLogNote
from sqlmodel.ext.asyncio.session import AsyncSession
from app.schemas import BusinessPartnerCreate, BusinessPartnerUpdate


class BusinessPartnerCRUD(
    CRUDBase[TblBusinessPartner, BusinessPartnerCreate, BusinessPartnerUpdate]
):

    async def create(
        self,
        obj_in: BusinessPartnerCreate,
        created_by_id: UUID,
        db_session: AsyncSession | None = None,
    ) -> TblBusinessPartner:
        try:
            db_session = db_session or super().get_db().session
            bp_obj = TblBusinessPartner(**obj_in.dict(), created_by_id=created_by_id)
            bp_log_obj = TblBpLogNote(
                note=f"Business Partner {bp_obj.bpName} created.",
                created_by_id=created_by_id,
                created_at=datetime.now(),
            )
            bp_obj.logNotes.append(bp_log_obj)
            db_session.add(bp_obj)
            await db_session.commit()
            await db_session.refresh(bp_obj)
            return bp_obj
        except Exception as e:
            await db_session.rollback()
            raise e

    async def update(
        self,
        id: int,
        obj_in: BusinessPartnerUpdate,
        db_session: AsyncSession | None = None,
    ) -> TblBusinessPartner:
        db_session = db_session or super().get_db().session
        return await super().update(id=id, obj_in=obj_in, db_session=db_session)

    async def get(
        self,
        id: int,
        db_session: AsyncSession | None = None,
    ) -> TblBusinessPartner:
        db_session = db_session or super().get_db().session
        return await super().get(id=id, db_session=db_session)

    async def get_all(
        self,
        *,
        isActive: bool | None = Query(None),
        keyword: str = Query(""),
        db_session: AsyncSession | None = None,
    ) -> list[TblBusinessPartner]:
        db_session = db_session or super().get_db().session
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.bpName.ilike(f"%{keyword}%"),
                    self.model.bpType.ilike(f"%{keyword}%"),
                ),
                or_(isActive == None, self.model.isActive.is_(isActive)),
            )
            .order_by(self.model.bpName)
        )
        response = await db_session.execute(query)
        return response.scalars().all()


businessPartner = BusinessPartnerCRUD(TblBusinessPartner)
