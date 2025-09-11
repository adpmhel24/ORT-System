from app.models import TblEmplPosition, TblLogEmplPosition
from sqlmodel import or_, select
from .base_crud import CRUDBase
from sqlmodel.ext.asyncio.session import AsyncSession
from app.schemas import EmplPositionCreate, EmplPositionRead, EmplPositionUpdate


class EmplPositionCRUD(
    CRUDBase[TblEmplPosition, EmplPositionCreate, EmplPositionUpdate]
):
    async def create(
        self,
        obj_in: EmplPositionCreate,
        created_by_id: int,
        db_session: AsyncSession | None = None,
    ) -> TblEmplPosition:
        try:
            db_session = db_session or super().get_db().session
            empl_position_obj = TblEmplPosition(**obj_in.dict())
            empl_position_log = TblLogEmplPosition(
                notes=f"Employee Position {empl_position_obj.code} created.",
                created_by_id=created_by_id,
            )
            empl_position_obj.logNotes.append(empl_position_log)
            db_session.add(empl_position_obj)
            await db_session.commit()
            await db_session.refresh(empl_position_obj)
            return empl_position_obj
        except Exception as e:
            await db_session.rollback()
            raise e

    async def update(
        self,
        id: int,
        obj_in: EmplPositionUpdate,
        created_by_id: int,
        db_session: AsyncSession | None = None,
    ) -> TblEmplPosition:
        try:
            db_session = db_session or super().get_db().session
            empl_position = await super().get(id=id, db_session=db_session)

            update_data = obj_in.dict(exclude_unset=True)
            if (
                "isActive" in update_data
                and update_data["isActive"] != empl_position.isActive
            ):
                status = "activated" if update_data["isActive"] else "deactivated"
                log_note = TblLogEmplPosition(
                    notes=f"Employee Position {empl_position.code} updated.",
                    created_by_id=created_by_id,
                )
                db_session.add(log_note)

            empl_position = await super().update(
                id=id, obj_in=obj_in, db_session=db_session
            )
            return empl_position
        except Exception as e:
            await db_session.rollback()
            raise e

    async def get(
        self,
        id: int,
        db_session: AsyncSession | None = None,
    ) -> TblEmplPosition:
        db_session = db_session or super().get_db().session
        return await super().get(id=id, db_session=db_session)

    async def get_all(
        self,
        *,
        is_active: bool | None = None,
        keyword: str = "",
        db_session: AsyncSession | None = None,
    ) -> list[TblEmplPosition]:
        db_session = db_session or super().get_db().session
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.code.ilike(f"%{keyword}%"),
                    self.model.description.ilike(f"%{keyword}%"),
                ),
                or_(is_active is None, self.model.isActive.is_(is_active)),
            )
            .order_by(self.model.code)
        )
        response = await db_session.execute(query)
        return response.scalars().all()


emplPosition = EmplPositionCRUD(TblEmplPosition)
