from app.models.job_order_model import JobOrderBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class JobOrderCreate(JobOrderBase):
    pass

class JobOrderRead(UpdatedSchema, CreatedSchema, IdSchema, JobOrderBase):
    pass

class JobOrderUpdate(JobOrderBase):
    pass
