from typing import Any
from fastapi import APIRouter, Body, Depends, Query, status
from fastapi_pagination import Params

from app.api import deps
from app.models import TblUser
from app.schemas.personnel_schema import PersonnelCreate, PersonnelRead
from app.schemas.response_schema import (
    IPostResponseBase,
    IGetResponsePaginated,
    ICancelResponseBase,
    IGetResponseBase,
    IPutResponseBase,
    http_response,
)

from app import crud


router = APIRouter()


@router.post("", status_code=status.HTTP_201_CREATED)
async def create(
    obj_in: PersonnelCreate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPostResponseBase[PersonnelRead]:
    result = await crud.personnel.create(obj_in=obj_in, created_by_id=current_user.id)
    return http_response(message="Added Successfully", data=result)


@router.get("")
async def get_all(
    # params: Params = Depends(),
    # from_date: str = Query(""),
    # to_date: str = Query(""),
    keyword: str = Query(""),
    # docstatus: str = Query(""),
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[list[PersonnelRead]]:
    result = await crud.personnel.get_all(
        keyword=keyword,
        # params=params,
        # docstatus=docstatus,
    )
    return http_response(data=result)


@router.get("/{id}")
async def get_by_id(
    id: int,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[PersonnelRead]:
    result = await crud.personnel.get(id=id)

    return http_response(data=result)
