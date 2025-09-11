from typing import Any
from fastapi import APIRouter, Body, Depends, Query, status
from fastapi_pagination import Params

from app.api import deps
from app.models import TblUser
from app.schemas import BusinessPartnerCreate, BusinessPartnerRead
from app.schemas.response_schema import (
    IPostResponseBase,
    IGetResponsePaginated,
    ICancelResponseBase,
    IGetResponseBase,
    IPutResponseBase,
    http_response,
)

from app.crud import businessPartner as crud


router = APIRouter()


@router.post("", status_code=status.HTTP_201_CREATED)
async def create(
    obj_in: BusinessPartnerCreate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPostResponseBase[BusinessPartnerRead]:
    result = await crud.create(obj_in=obj_in, created_by_id=current_user.id)
    return http_response(message="Added Successfully", data=result)


@router.get("")
async def get_all(
    # params: Params = Depends(),
    # from_date: str = Query(""),
    # to_date: str = Query(""),
    keyword: str = Query(""),
    isActive: str = Query(None),
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[list[BusinessPartnerRead]]:
    result = await crud.get_all(
        keyword=keyword,
        # params=params,
        isActive=isActive,
    )
    return http_response(data=result)


@router.get("/{id}")
async def get_by_id(
    id: int,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[BusinessPartnerRead]:
    result = await crud.get(id=id)

    return http_response(data=result)
