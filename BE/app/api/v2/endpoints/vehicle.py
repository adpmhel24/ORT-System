from typing import Any
from fastapi import APIRouter, Body, Depends, Query, status
from fastapi_pagination import Params

from app.api import deps
from app.models import TblUser
from app.schemas import VehicleCreate, VehicleRead, VehicleUpdate
from app.schemas.response_schema import (
    IPostResponseBase,
    IGetResponsePaginated,
    ICancelResponseBase,
    IGetResponseBase,
    IPutResponseBase,
    http_response,
)

from app.crud import vehicle as vehicle_crud


router = APIRouter()


@router.post("", status_code=status.HTTP_201_CREATED)
async def create(
    obj_in: VehicleCreate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPostResponseBase[VehicleRead]:
    result = await vehicle_crud.create(obj_in=obj_in, created_by_id=current_user.id)
    return http_response(message="Added Successfully", data=result)


@router.get("")
async def get_all(
    keyword: str = Query(""),
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[list[VehicleRead]]:
    result = await vehicle_crud.get_all(
        keyword=keyword,
    )
    return http_response(data=result)


@router.get("/{id}")
async def get_by_id(
    id: int,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[VehicleRead]:
    result = await vehicle_crud.get(id=id)

    return http_response(data=result)
