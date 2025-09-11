from datetime import datetime
from typing import List
from sqlmodel import SQLModel
from app.models.job_order_model import JobOrderBase, JobOrderLogBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema


# JobOrder schemas
class JobOrderCreate(JobOrderBase):
    pass


class JobOrderRead(IdSchema, JobOrderBase):
    logNotes: List["JobOrderLogRead"] = []


class JobOrderUpdate(SQLModel):
    jobDate: datetime | None = None
    remarks: str | None = None
    jobDescription: str | None = None
    status: str | None = None
    pickupAddress: str | None = None
    deliveryAddress: str | None = None
    pickupLat: float | None = None
    pickupLong: float | None = None
    deliveryLat: float | None = None
    deliveryLong: float | None = None


# JobOrderLog schemas
class JobOrderLogCreate(JobOrderLogBase):
    pass


class JobOrderLogRead(IdSchema, JobOrderLogBase):
    pass


class JobOrderLogUpdate(SQLModel):
    notes: str | None = None
