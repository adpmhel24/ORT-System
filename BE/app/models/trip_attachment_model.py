from sqlmodel import SQLModel, Field

from app.models.base_model import (
    BaseCancelledModel,
    BaseCreatedModel,
    BaseUpdatedModel,
    BaseIdModel,
)


class TripAttachmentBase(SQLModel):

    trip_id: int = Field(
        foreign_key="TblTrip.id", fk_kwargs={"ondelete": "CASCADE"}
    )



class TblTripAttachment(
    BaseCancelledModel,
    BaseUpdatedModel,
    BaseCreatedModel,
    TripAttachmentBase,
    BaseIdModel,
    table=True,
):
    pass
