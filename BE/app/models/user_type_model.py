from sqlmodel import Field, SQLModel, Relationship
from .base_model import BaseCreatedModel, BaseUpdatedModel


class UserTypeBase(SQLModel):
    code: str = Field(primary_key=True, description="User Type")
    description: str | None


class TblUserType(UserTypeBase, BaseCreatedModel, BaseUpdatedModel, table=True):
    pass
