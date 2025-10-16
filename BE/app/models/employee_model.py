from datetime import datetime
from typing import TYPE_CHECKING
from sqlmodel import Field, SQLModel, Relationship
from .base_model import BaseCreatedModel, BaseIdModel

if TYPE_CHECKING:
    from .empl_position_model import TblEmplPosition


class EmployeeBase(SQLModel):
    employeeId: str = Field(unique=True, index=True)
    firstName: str
    lastName: str
    email: str | None
    phoneNumber: str | None
    dateStarted: datetime = Field(default_factory=datetime.now)
    positionCode: str = Field(
        foreign_key="TblEmplPosition.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    dailyRate: float
    sss_number: str | None
    philhealth_number: str | None
    pagibig_number: str | None
    tax_number: str | None
    sssContri: float | None = Field(default_factory=0.00)
    philhealthContri: float | None = Field(default_factory=0.00)
    pagibigContri: float | None = Field(default_factory=0.00)
    tax: float | None = Field(default_factory=0.00)
    sickLeave: int | None = Field(default_factory=0)
    vacationLeave: int | None = Field(default_factory=0)


class TblEmployee(EmployeeBase, BaseIdModel, table=True):
    position: "TblEmplPosition" = Relationship(back_populates="employees")

    class Config:
        populate_by_name = True
        alias_generator = None


class LogEmployeeBase(SQLModel):
    logNotes: str


class TblLogEmployee(BaseCreatedModel, BaseIdModel, LogEmployeeBase, table=True):
    class Config:
        populate_by_name = True
        alias_generator = None
