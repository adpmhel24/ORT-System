from typing import List
from uuid import UUID
from fastapi import APIRouter, Depends, Query, status
from sqlmodel.ext.asyncio.session import AsyncSession
from app.api import deps
from app.crud import emplPosition
from app.models.user_model import TblUser
from app.schemas import EmplPositionCreate, EmplPositionUpdate, EmplPositionRead
from app.schemas.response_schema import (
    IGetResponseBase,
    IPostResponseBase,
    IPutResponseBase,
    http_response,
)

router = APIRouter()


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_empl_position(
    obj_in: EmplPositionCreate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPostResponseBase[EmplPositionRead]:
    obj = await emplPosition.create(obj_in=obj_in, created_by_id=current_user.id)
    return http_response(message="Added Successfully", data=obj)


@router.get("")
async def get_empl_positions(
    keyword: str = Query(""),
    isActive: str = Query(None),
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[list[EmplPositionRead]]:
    objs = await emplPosition.get_all(
        keyword=keyword,
        is_active=isActive,
    )
    return http_response(data=objs)


@router.get("/{id}")
async def get_empl_position(
    id: int,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IGetResponseBase[EmplPositionRead]:
    obj = await emplPosition.get(id=id)
    return http_response(data=obj)


@router.put("/{id}")
async def update_empl_position(
    id: int,
    obj_in: EmplPositionUpdate,
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPutResponseBase[EmplPositionRead]:
    obj = await emplPosition.update(id=id, obj_in=obj_in, created_by_id=current_user.id)
    return http_response(message="Updated Successfully", data=obj)
