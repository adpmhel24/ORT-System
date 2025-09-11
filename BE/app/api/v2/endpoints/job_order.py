from typing import List
from uuid import UUID
from fastapi import APIRouter, Depends, Query, status
from sqlmodel.ext.asyncio.session import AsyncSession

from app.crud.job_order_crud import jobOrder
from app.api import deps
from app.models.job_order_model import JobOrderStatus
from app.models.user_model import TblUser
from app.schemas.job_order_schema import JobOrderCreate, JobOrderUpdate, JobOrderRead
from app.schemas.response_schema import (
    IGetResponseBase,
    IPostResponseBase,
    IPutResponseBase,
    http_response,
)

router = APIRouter()


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_job_order(
    job_order_in: JobOrderCreate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPostResponseBase[JobOrderRead]:
    """
    Create new job order.
    """
    job_order = await jobOrder.create(
        obj_in=job_order_in,
        created_by_id=current_user.id,
    )
    return http_response(message="Added Successfully", data=job_order)


@router.get("")
async def get_job_orders(
    status: JobOrderStatus | None = Query(None),
    keyword: str = Query(""),
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[List[JobOrderRead]]:
    """
    Retrieve job orders.
    """
    job_orders = await jobOrder.get_all(
        status=status,
        keyword=keyword,
    )
    return http_response(data=job_orders)


@router.get("/{job_order_id}")
async def get_job_order(
    job_order_id: UUID,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[JobOrderRead]:
    """
    Get job order by ID.
    """
    job_order = await jobOrder.get(id=job_order_id)
    return http_response(data=job_order)


@router.put("/{job_order_id}")
async def update_job_order(
    job_order_id: UUID,
    job_order_in: JobOrderUpdate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPutResponseBase[JobOrderRead]:
    """
    Update a job order.
    """
    job_order = await jobOrder.update(
        id=job_order_id,
        obj_in=job_order_in,
        created_by_id=current_user.id,
    )
    return http_response(message="Successfully updated.", data=job_order)
