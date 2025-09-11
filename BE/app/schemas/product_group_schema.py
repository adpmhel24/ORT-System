from models.product_group_model import ProductGroupBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class ProductGroupCreate(ProductGroupBase):
    pass

class ProductGroupRead(UpdatedSchema, CreatedSchema, IdSchema, ProductGroupBase):
    pass

class ProductGroupUpdate(ProductGroupBase):
    pass
