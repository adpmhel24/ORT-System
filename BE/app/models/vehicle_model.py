from sqlmodel import Field, SQLModel
from .base_model import BaseCreatedModel, BaseUpdatedModel, BaseIdModel


class VehicleBase(SQLModel):
    plateNumber: str = Field(unique=True)
    yearModel: int
    maker: str
    category: str
    orNumber: str | None
    crNumber: str | None
    fuelLevel: float = Field(default=0.00, description="In liters")
    currentMiliage: int = Field(default=0)
    minDiesel: float = Field(default=0.00)
    withLoadConsumption: float = Field(
        default=0.00, description="It should be estimated consumed km/l"
    )
    withOutLoadConsumption: float = Field(
        default=0.00, description="It should be estimated consumed km/l"
    )
    status: str = Field(description="available, unavailable, inMaintenance, retired")


class TblVehicle(
    VehicleBase, BaseCreatedModel, BaseUpdatedModel, BaseIdModel, table=True
):
    pass


class VehicleLogNoteBase(SQLModel):
    id: int = Field(default=None, primary_key=True)
    vehicleId: int = Field(foreign_key="TblVehicle.id")
    note: str


class TblVehicleLogNote(
    BaseCreatedModel,
    BaseUpdatedModel,
    VehicleLogNoteBase,
    BaseIdModel,
    table=True,
):
    pass
