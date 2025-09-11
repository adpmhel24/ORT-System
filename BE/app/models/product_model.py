from sqlmodel import Field, SQLModel
from .base_model import BaseCreatedModel, BaseUpdatedModel



class ProductBase(SQLModel):
    name: str = Field(unique=True, index=True, primary_key=True,)
    product_group_code: str = Field(foreign_key="TblProductGroup.code",fk_kwargs={"onupdate": "CASCADE"},)


class TblProduct(ProductBase, BaseCreatedModel, BaseUpdatedModel, table=True):
    pass

