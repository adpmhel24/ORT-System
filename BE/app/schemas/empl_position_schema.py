from app.models.empl_position_model import EmplPositionBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class EmplPositionCreate(EmplPositionBase):
    pass

class EmplPositionRead(UpdatedSchema, CreatedSchema, IdSchema, EmplPositionBase):
    pass

class EmplPositionUpdate(EmplPositionBase):
    pass
