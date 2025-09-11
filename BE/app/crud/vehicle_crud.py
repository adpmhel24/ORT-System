from uuid import UUID
from fastapi import Query
from sqlmodel import or_, select
from .base_crud import CRUDBase
from app.models import TblVehicle
from sqlmodel.ext.asyncio.session import AsyncSession
from app.schemas import VehicleCreate, VehicleUpdate


class VehicleCRUD(CRUDBase[TblVehicle, VehicleCreate, VehicleUpdate]):
    async def get_all(
        self,
        *,
        keyword: str = Query(""),
        db_session: AsyncSession | None = None,
    ) -> list[TblVehicle]:
        db_session = db_session or super().get_db().session
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.plateNumber.ilike(f"%{keyword}%"),
                    self.model.maker.ilike(f"%{keyword}%"),
                ),
            )
            .order_by(self.model.plateNumber)
        )
        response = await db_session.execute(query)
        return response.scalars().all()


vehicle = VehicleCRUD(TblVehicle)
