from models.order_model import OrderHeaderBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class OrderHeaderCreate(OrderHeaderBase):
    pass

class OrderHeaderRead(UpdatedSchema, CreatedSchema, IdSchema, OrderHeaderBase):
    pass

class OrderHeaderUpdate(OrderHeaderBase):
    pass
