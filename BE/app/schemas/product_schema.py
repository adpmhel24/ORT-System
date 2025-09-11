from models.product_model import ProductBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class ProductCreate(ProductBase):
    pass

class ProductRead(UpdatedSchema, CreatedSchema, IdSchema, ProductBase):
    pass

class ProductUpdate(ProductBase):
    pass
