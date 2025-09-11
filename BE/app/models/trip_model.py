from sqlmodel import SQLModel, Field

from app.models.base_model import (
    BaseCancelledModel,
    BaseCreatedModel,
    BaseUpdatedModel,
    BaseIdModel,
)


class TripBase(SQLModel):

    vehicle_id: str = Field(foreign_key="TblVehicle.id")
    driver_id: int = Field(
        foreign_key="TblDriver.id",
    )
    step1: str | None = Field(description="O = Open, C = Closed")
    step2: str | None = Field(description="O = Open, C = Closed")
    step3: str | None = Field(description="O = Open, C = Closed")
    step4: str | None = Field(description="O = Open, C = Closed")
    step5: str | None = Field(description="O = Open, C = Closed")


class TblTrip(
    BaseCancelledModel,
    BaseUpdatedModel,
    BaseCreatedModel,
    TripBase,
    BaseIdModel,
    table=True,
):
    pass
