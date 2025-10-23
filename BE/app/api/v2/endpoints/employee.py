# from typing import List
# from uuid import UUID
# from fastapi import APIRouter, Depends, Query, status
# from sqlmodel.ext.asyncio.session import AsyncSession
# from app.api import deps
# from app.crud import employee
# from app.models.user_model import TblUser
# from app.schemas import EmployeeCreate, EmployeeUpdate, EmployeeRead
# from app.schemas.response_schema import (
#     IGetResponseBase,
#     IPostResponseBase,
#     IPutResponseBase,
#     http_response,
# )

# router = APIRouter()


# @router.post("", status_code=status.HTTP_201_CREATED)
# async def create_employee(
#     obj_in: EmployeeCreate,
#     current_user: TblUser = Depends(deps.get_current_user()),
# ) -> IPostResponseBase[EmployeeRead]:
#     obj = await employee.create(obj_in=obj_in, created_by_id=current_user.id)
#     return http_response(message="Added Successfully", data=obj)


# @router.get("")
# async def get_employees(
#     keyword: str = Query(""),
#     isActive: str = Query(None),
#     current_user: TblUser = Depends(deps.get_current_user()),
# ) -> IGetResponseBase[List[EmployeeRead]]:
#     objs = await employee.get_all(
#         keyword=keyword,
#         is_active=isActive,
#     )
#     return http_response(data=objs)


# @router.get("/{id}")
# async def get_employee(
#     id: int,
#     current_user: TblUser = Depends(deps.get_current_user()),
# ) -> IGetResponseBase[EmployeeRead]:
#     obj = await employee.get(id=id)
#     return http_response(data=obj)


# @router.put("/{id}")
# async def update_employee(
#     id: int,
#     obj_in: EmployeeUpdate,
#     current_user: TblUser = Depends(deps.get_current_user()),
# ) -> IPutResponseBase[EmployeeRead]:
#     obj = await employee.update(id=id, obj_in=obj_in, created_by_id=current_user.id)
#     return http_response(message="Updated Successfully", data=obj)
