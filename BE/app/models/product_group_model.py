from sqlmodel import Field, SQLModel
from .base_model import BaseCreatedModel, BaseUpdatedModel



class ProductGroupBase(SQLModel):
    code: str = Field(unique=True, index=True, primary_key=True,)


class TblProductGroup(ProductGroupBase, BaseCreatedModel, BaseUpdatedModel, table=True):
    pass

