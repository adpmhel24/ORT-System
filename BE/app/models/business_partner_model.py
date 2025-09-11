from sqlmodel import Field, SQLModel, Relationship
from sqlalchemy.orm import relationship
from .base_model import BaseCreatedModel, BaseUpdatedModel, BaseIdModel


class BusinessPartnerBase(SQLModel):
    bpName: str = Field(
        unique=True,
        index=True,
    )
    bpType: str = Field(description="supplier, customer")
    contactPerson: str | None = Field(
        description="Name of the contact person for the business partner"
    )
    address: str | None
    contactNumber: str | None
    lat: float | None
    long: float | None
    isActive: bool = Field(default=True, description="Is the business partner active?")


class TblBusinessPartner(
    BusinessPartnerBase, BaseCreatedModel, BaseUpdatedModel, BaseIdModel, table=True
):
    logNotes: list["TblBpLogNote"] = Relationship(
        sa_relationship_kwargs={
            "order_by": "TblBpLogNote.id.desc()",
        }
    )  # noqa: F821


class BpLogNoteBase(SQLModel):
    note: str


class TblBpLogNote(
    BaseCreatedModel,
    BaseUpdatedModel,
    BpLogNoteBase,
    BaseIdModel,
    table=True,
):
    bpId: int = Field(
        foreign_key="TblBusinessPartner.id",
        fk_kwargs={"ondelete": "CASCADE"},
        index=True,
    )
