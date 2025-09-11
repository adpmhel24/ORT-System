from typing import TypeVar
from sqlmodel import SQLModel
from ..models.base_model import (
    BaseCreatedModel,
    BaseCancelledModel,
    BaseUpdatedModel,
    BaseIdModel,
    BaseUUIDModel,
)


SchemaType = TypeVar("SchemaType", bound=SQLModel)


# class HeaderBaseSchema(SQLModel):
#     id: int


# class RowBaseSchema(SQLModel):
#     id: int
#     header_id: int


class UUIDSchema(BaseUUIDModel):
    pass


class IdSchema(BaseIdModel):
    pass


class CreatedSchema(BaseCreatedModel):
    pass


class UpdatedSchema(BaseUpdatedModel):
    pass
