from datetime import datetime
from typing import List
from uuid import UUID
from fastapi import Query
from sqlmodel import select, or_
from sqlmodel.ext.asyncio.session import AsyncSession

from app.models.job_order_model import (
    TblJobOrder,
    TblJobOrderLog,
    JobOrderStatus,
    generate_reference_number,
)
from app.schemas.job_order_schema import JobOrderCreate, JobOrderUpdate
from .base_crud import CRUDBase


class JobOrderCRUD(CRUDBase[TblJobOrder, JobOrderCreate, JobOrderUpdate]):
    async def create(
        self,
        obj_in: JobOrderCreate,
        created_by_id: UUID,
        db_session: AsyncSession | None = None,
    ) -> TblJobOrder:
        try:
            db_session = db_session or super().get_db().session
            job_order_obj = TblJobOrder(**obj_in.dict())
            job_order_obj.reference = await generate_reference_number(db_session)
            # job_order_log = TblJobOrderLog(
            #     notes=f"Job Order {job_order_obj.reference} created with status {job_order_obj.status}.",
            #     created_by_id=created_by_id,
            #     created_at=datetime.now(),
            # )
            # job_order_obj.logNotes.append(job_order_log)
            db_session.add(job_order_obj)
            await db_session.commit()
            await db_session.refresh(job_order_obj)
            return job_order_obj
        except Exception as e:
            await db_session.rollback()
            raise e

    async def update(
        self,
        id: UUID,
        obj_in: JobOrderUpdate,
        created_by_id: UUID,
        db_session: AsyncSession | None = None,
    ) -> TblJobOrder:
        try:
            db_session = db_session or super().get_db().session
            job_order = await super().get(id=id, db_session=db_session)

            update_data = obj_in.dict(exclude_unset=True)
            if "status" in update_data and update_data["status"] != job_order.status:
                log_note = TblJobOrderLog(
                    notes=f"Status changed from {job_order.status} to {update_data['status']}",
                    created_by_id=created_by_id,
                    jobOrderId=id,
                )
                db_session.add(log_note)

            job_order = await super().update(
                id=id, obj_in=obj_in, db_session=db_session
            )
            await db_session.commit()
            await db_session.refresh(job_order)
            return job_order
        except Exception as e:
            await db_session.rollback()
            raise e

    async def get_all(
        self,
        *,
        status: JobOrderStatus | None = Query(None),
        keyword: str = Query(""),
        db_session: AsyncSession | None = None,
    ) -> List[TblJobOrder]:
        db_session = db_session or super().get_db().session
        query = (
            select(self.model)
            .where(
                or_(
                    keyword == "",
                    self.model.jobDescription.ilike(f"%{keyword}%"),
                    self.model.pickupAddress.ilike(f"%{keyword}%"),
                    self.model.deliveryAddress.ilike(f"%{keyword}%"),
                ),
                or_(status == None, self.model.status == status),
            )
            .order_by(self.model.id)
        )
        response = await db_session.execute(query)
        return response.scalars().all()


jobOrder = JobOrderCRUD(TblJobOrder)
