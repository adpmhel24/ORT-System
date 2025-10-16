from fastapi import APIRouter
from .endpoints import (
    user,
    login,
    personnel,
    vehicle,
    business_partner,
    job_order,
    empl_position,
    # gl_type,
)

api_router = APIRouter()
api_router.include_router(login.router, prefix="/login", tags=["Login"])
api_router.include_router(user.router, prefix="/user", tags=["User"])
api_router.include_router(
    personnel.router, prefix="/masterdata/personnel", tags=["Personnel"]
)
api_router.include_router(
    vehicle.router, prefix="/masterdata/vehicle", tags=["Vehicle"]
)
api_router.include_router(
    business_partner.router, prefix="/masterdata/bp", tags=["Business Partner"]
)
api_router.include_router(
    empl_position.router,
    prefix="/masterdata/employee-position",
    tags=["Business Partner"],
)
api_router.include_router(job_order.router, prefix="/job-order", tags=["Job Order"])
