from sqlmodel import Field, SQLModel
from .base_model import BaseCreatedModel, BaseUpdatedModel, BaseIdModel


class PersonnelBase(SQLModel):
    fullName: str = Field(unique=True)
    licenseNumber: str | None = Field(unique=True)
    role: str | None
    isActive: bool = Field(default=True)


class TblPersonnel(
    PersonnelBase, BaseCreatedModel, BaseUpdatedModel, BaseIdModel, table=True
):
    pass
