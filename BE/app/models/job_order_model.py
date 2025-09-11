from datetime import datetime
from enum import Enum
from typing import List
from sqlmodel import Field, SQLModel, Relationship
from sqlalchemy import event
from sqlalchemy.ext.asyncio import AsyncSession
from .base_model import BaseCreatedModel, BaseIdModel


class JobOrderStatus(str, Enum):
    PENDING = "Pending"
    ASSIGNED = "Assigned"
    CANCELED = "Canceled"
    INTRANSIT = "In Transit"
    DONE = "Done"


class JobOrderBase(SQLModel):
    bpName: str = Field(foreign_key="TblBusinessPartner.bpName", index=True)
    contactNumber: str | None
    jobDate: datetime = Field(default_factory=datetime.now)
    remarks: str | None = None
    jobDescription: str
    status: JobOrderStatus = Field(default=JobOrderStatus.PENDING, index=True)
    pickupAddress: str
    deliveryAddress: str
    pickupLat: float
    pickupLong: float
    deliveryLat: float
    deliveryLong: float


class TblJobOrder(JobOrderBase, BaseIdModel, table=True):
    reference: str = Field(unique=True, index=True)
    logNotes: List["TblJobOrderLog"] = Relationship(
        sa_relationship_kwargs={
            "order_by": "TblJobOrderLog.id.desc()",
        },
    )


class JobOrderLogBase(SQLModel):
    notes: str


class TblJobOrderLog(JobOrderLogBase, BaseCreatedModel, BaseIdModel, table=True):
    jobOrderId: int = Field(foreign_key="TblJobOrder.id", index=True)


async def generate_reference_number(session: AsyncSession) -> str:
    """Generate a reference number in the format JO-MMDDYY-000001"""
    today = datetime.now()
    date_part = today.strftime("%m%d%y")

    # Get the latest reference number for today
    result = await session.execute(
        f"""
        SELECT reference
        FROM "TblJobOrder"
        WHERE reference LIKE 'JO-{date_part}-%'
        ORDER BY reference DESC
        LIMIT 1
        """
    )
    latest_ref = result.scalar()

    if latest_ref:
        # Extract the sequence number and increment it
        seq_num = int(latest_ref.split("-")[2]) + 1
    else:
        # Start with 1 if no reference exists for today
        seq_num = 1

    # Format the new reference number
    reference = f"JO-{date_part}-{seq_num:06d}"
    return reference


@event.listens_for(TblJobOrder, "before_insert")
def set_reference_before_insert(mapper, connection, target):
    # Since we're in a sync event listener but need to run async code,
    # we'll set a flag to generate the reference in the API layer
    if not target.reference:
        target.reference = "PENDING_GENERATION"
