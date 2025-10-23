from app.models.employee_model import EmployeeBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class EmployeeCreate(EmployeeBase):
    pass

class EmployeeRead(UpdatedSchema, CreatedSchema, IdSchema, EmployeeBase):
    pass

class EmployeeUpdate(EmployeeBase):
    pass
