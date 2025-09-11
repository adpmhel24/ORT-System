from select import select
from fastapi import APIRouter, Depends, Query, status
from fastapi_pagination import Params
from app.schemas.user_schema import UserCreate, UserRead
from app.api import deps
from app.deps import user_deps
from app.models import TblUser
from app.schemas.response_schema import (
    IPostResponseBase,
    IGetResponsePaginated,
    http_response,
)
from app import crud

router = APIRouter()


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_user(
    new_user: UserCreate = Depends(user_deps.user_exists),
    current_user: TblUser = Depends(deps.get_current_user()),
) -> IPostResponseBase[UserRead]:
    """
    Creates a new user

    Required roles:
    - admin
    """
    user = await crud.user.create_with_role(
        obj_in=new_user, created_user_id=current_user.id
    )
    return http_response(data=user)


# @router.put("/change_password")
# async def change_password(
#     obj_in: IUserChangePassword,
#     current_user: TblUser = Depends(deps.get_current_user()),
# ) -> IPostResponseBase[IUserRead]:
#     user = await crud.user.change_password(user_id=current_user.id, obj_in=obj_in)
#     return http_response(message="Update successfully", data=user)


# @router.get("")
# async def get_all(
#     params: Params = Depends(),
#     keyword: str = Query(""),
#     current_user: TblUser = Depends(deps.get_current_user()),
# ) -> IGetResponsePaginated[UserRead]:
#     user = await crud.user.get_all_paginated(params=params, keyword=keyword)
#     return http_response(data=user)
