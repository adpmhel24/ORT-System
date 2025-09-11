from datetime import datetime
from pydantic import condecimal
from sqlmodel import SQLModel, Relationship, Field, text
from app.models.base_model import (
    BaseCreatedModel,
    BaseUpdatedModel,
    BaseIdModel,
    BaseCancelledModel,
)


class OrderHeaderBase(SQLModel):
    docdate: datetime | None = Field(default_factory=datetime.now)
    docstatus: str = Field(
        default="O", index=True, sa_column_kwargs={"server_default": "O"}
    )
    canceled: str = Field(default="N", index=True)
    customer_name: str | None = Field(
        foreign_key="TblCustomer.name",
        fk_kwargs={
            "onupdate": "CASCADE",
            "ondelete": "RESTRICT",
        },
    )
    del_address: str|None = Field(nullable=True, description="Delivery Address")
    remarks: str | None


class TblOrderHeader(
    BaseCancelledModel,
    BaseUpdatedModel,
    BaseCreatedModel,
    OrderHeaderBase,
    BaseIdModel,
    table=True,
):
    reference: str | None = Field(unique=True, index=True, nullable=True)
    rows: list["TblOrderRow"] = Relationship(
        back_populates="header", sa_relationship_kwargs={"lazy": "joined"}
    )  # noqa: F821
  


class OrderRowBase(SQLModel):
    product_name: str = Field(
        foreign_key="TblProduct.name",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        nullable=False,
    )
    warehouse_code: str = Field(foreign_key="TblWarehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        nullable=False,)
    quantity: condecimal(max_digits=20, decimal_places=2) = Field(
        default=0.00,
        description="Quantity",
        sa_column_kwargs={"server_default": text("0.00")},
    )
    balance: condecimal(max_digits=20, decimal_places=2) = Field(
        default=0.00,
        description="Balance",
        sa_column_kwargs={"server_default": text("0.00")},
    )
 


class TblOrderRow(
    BaseUpdatedModel,
    BaseCreatedModel,
    OrderRowBase,
    BaseIdModel,
    table=True,
):
    header_id: int = Field(
        nullable=False,
        foreign_key="TblOrderHeader.id",
        fk_kwargs={"ondelete": "CASCADE"},
        index=True,
    )
    header: "TblOrderHeader" = Relationship(back_populates="rows")  # noqa: F821

