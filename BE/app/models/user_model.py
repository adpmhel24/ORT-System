from typing import TYPE_CHECKING
from app.models.base_model import BaseUUIDModel
from sqlmodel import Field, SQLModel, Relationship
from pydantic import EmailStr
from .base_model import BaseCreatedModel, BaseUpdatedModel


class UserBase(SQLModel):
    email: EmailStr
    fullname: str
    is_active: bool = Field(default=True)
    is_superuser: bool = Field(default=False)
    is_admin: bool = Field(default=False, description="True if they are web user")
    user_type_code: str | None = Field(
        foreign_key="TblUserType.code", fk_kwargs={"onupdate": "CASCADE"}, nullable=True
    )


class TblUser(UserBase, BaseCreatedModel, BaseUpdatedModel, BaseUUIDModel, table=True):
    hashed_password: str | None = Field(nullable=False, index=True)
