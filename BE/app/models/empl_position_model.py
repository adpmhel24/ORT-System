from typing import TYPE_CHECKING
from sqlmodel import SQLModel, Field, Relationship
from .base_model import BaseIdModel, BaseCreatedModel

if TYPE_CHECKING:
    from .employee_model import TblEmployee


class EmplPositionBase(SQLModel):
    code: str = Field(index=True, primary_key=True, unique=True)
    description: str | None = None
    isActive: bool = Field(
        default=True, description="Indicates if the position is active"
    )


class TblEmplPosition(EmplPositionBase, table=True):

    __tablename__ = "TblEmplPosition"

    employees: list["TblEmployee"] = Relationship(back_populates="position")
    logNotes: list["TblLogEmplPosition"] = Relationship(back_populates="position")

    class Config:
        populate_by_name = True
        alias_generator = None


class LogEmplPositionBase(SQLModel):
    notes: str


class TblLogEmplPosition(
    BaseCreatedModel, BaseIdModel, LogEmplPositionBase, table=True
):
    positionCode: str = Field(foreign_key="TblEmplPosition.code", index=True)
    position: "TblEmplPosition" = Relationship(back_populates="logNotes")

    class Config:
        populate_by_name = True
        alias_generator = None
