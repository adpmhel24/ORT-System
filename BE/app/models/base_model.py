from app.utils.uuid6 import uuid7, UUID
from sqlmodel import Relationship, SQLModel as _SQLModel, Field
from sqlalchemy.orm import declared_attr
from datetime import datetime


# id: implements proposal uuid7 draft4


class SQLModel(_SQLModel):
    @declared_attr  # type: ignore
    def __tablename__(cls) -> str:
        return cls.__name__


class BaseUUIDModel(SQLModel):
    id: UUID = Field(
        default_factory=uuid7,
        primary_key=True,
        index=True,
        nullable=False,
    )


class BaseIdModel(SQLModel):
    id: int = Field(
        primary_key=True,
        index=True,
        nullable=False,
        sa_column_kwargs={"autoincrement": True},
    )


class BaseCreatedModel(SQLModel):
    created_by: UUID | None = Field(foreign_key="TblUser.id", index=True, nullable=True)
    created_at: datetime | None = Field(default_factory=datetime.now)


class BaseUpdatedModel(SQLModel):
    updated_by: UUID | None = Field(default=None, foreign_key="TblUser.id")
    updated_at: datetime | None = Field(
        default_factory=datetime.now, sa_column_kwargs={"onupdate": datetime.now}
    )


class BaseCancelledModel(SQLModel):
    canceled_by: UUID | None = Field(default=None, foreign_key="TblUser.id")
    canceled_at: datetime | None
