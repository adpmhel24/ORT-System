from app.models.user_model import UserBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class UserCreate(UserBase):
    pass

class UserRead(UpdatedSchema, CreatedSchema, IdSchema, UserBase):
    pass

class UserUpdate(UserBase):
    pass
