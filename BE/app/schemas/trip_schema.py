from models.trip_model import TripBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class TripCreate(TripBase):
    pass

class TripRead(UpdatedSchema, CreatedSchema, IdSchema, TripBase):
    pass

class TripUpdate(TripBase):
    pass
