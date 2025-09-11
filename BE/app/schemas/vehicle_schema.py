from app.models.vehicle_model import VehicleBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema


class VehicleCreate(VehicleBase):
    pass


class VehicleRead(UpdatedSchema, CreatedSchema, IdSchema, VehicleBase):
    pass


class VehicleUpdate(VehicleBase):
    pass
