from models.user_type_model import UserTypeBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class UserTypeCreate(UserTypeBase):
    pass

class UserTypeRead(UpdatedSchema, CreatedSchema, IdSchema, UserTypeBase):
    pass

class UserTypeUpdate(UserTypeBase):
    pass
