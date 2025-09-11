from ..models.employee_model import EmployeeBase, LogEmployeeBase
from .base_schema import IdSchema, CreatedSchema


class EmployeeCreate(EmployeeBase):
    pass


class EmployeeUpdate(EmployeeBase):
    pass


class EmployeeRead(CreatedSchema, EmployeeBase):
    logNotes: list["LogEmployeeRead"] = []


class LogEmployeeCreate(LogEmployeeBase):
    pass


class LogEmployeeRead(IdSchema, LogEmployeeBase):
    pass
