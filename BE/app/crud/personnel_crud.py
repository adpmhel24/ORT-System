from uuid import UUID
from fastapi import Query
from sqlmodel import or_, select
from .base_crud import CRUDBase
from app.models import TblPersonnel
from sqlmodel.ext.asyncio.session import AsyncSession
from app.schemas.personnel_schema import PersonnelCreate, PersonnelUpdate


class PersonnelCRUD(CRUDBase[TblPersonnel, PersonnelCreate, PersonnelUpdate]):
    async def get_all(
        self,
        *,
        is_active: bool | None = Query(None),
        keyword: str = Query(""),
        db_session: AsyncSession | None = None,
    ) -> list[TblPersonnel]:
        db_session = db_session or super().get_db().session
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.fullName.ilike(f"%{keyword}%"),
                    self.model.licenseNumber.ilike(f"%{keyword}%"),
                ),
                # or_(is_active == None, self.model.isActive.is_(is_active)),
            )
            .order_by(self.model.fullName)
        )
        response = await db_session.execute(query)
        return response.scalars().all()


personnel = PersonnelCRUD(TblPersonnel)
