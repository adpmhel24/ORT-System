# Core Application Instance
from sqlalchemy.exc import SQLAlchemyError
from fastapi import FastAPI, status, APIRouter, Request
from fastapi.encoders import jsonable_encoder
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException
from starlette.middleware.cors import CORSMiddleware
from fastapi_async_sqlalchemy import SQLAlchemyMiddleware, db
from fastapi_pagination import add_pagination
from app.api.v2.api import api_router as api_router_v2


from app.core.config import settings
from app.utils.fastapi_globals import GlobalsMiddleware

from app.utils.logging import logger
from app.utils.error_handler import RouteErrorHandler

router = APIRouter(route_class=RouteErrorHandler)
app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.API_VERSION,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
)

app.add_middleware(
    SQLAlchemyMiddleware,
    db_url=settings.ASYNC_DATABASE_URI,
    engine_args={
        "echo": False,
        "pool_pre_ping": True,
        "pool_size": settings.POOL_SIZE,
        "max_overflow": 64,
    },
)
app.add_middleware(GlobalsMiddleware)

# Set all CORS origins enabled
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

# Add Routers
app.include_router(router)
app.include_router(api_router_v2, prefix=settings.API_V1_STR)
add_pagination(app)


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    logger.exception(exc.errors())
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content=jsonable_encoder({"message": exc.errors()[0]["msg"]}),
    )


@app.exception_handler(AttributeError)
async def attribute_error_handler(request, err):
    # base_error_message = f"Failed to execute: {request.method}: {request.url}"
    # Change here to LOGGER

    logger.exception(err.args)
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
    )


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request, exc):
    logger.exception(exc.detail)

    return JSONResponse(
        status_code=exc.status_code, content=jsonable_encoder({"message": exc.detail})
    )


@app.exception_handler(ValueError)
async def value_error_handler(request, err):
    logger.exception(err.args)
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
    )


@app.exception_handler(TypeError)
async def type_error_handler(request, err):
    # base_error_message = f"Failed to execute: {request.method}: {request.url}"
    # Change here to LOGGER
    logger.exception(request)
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err}"}
    )


# @app.exception_handler(SQLAlchemyError)
# async def sqlalchemy_error_handler(request, err):
#     error = jsonable_encoder(err.args[0].rstrip().split("\n")[0])
#     if "unique" in error:
#         print(error)
#         error_detail = jsonable_encoder(err.args[0].rstrip().split("\n")[1])
#         return JSONResponse(
#             status_code=status.HTTP_400_BAD_REQUEST,
#             content={"message": f"{error_detail}"},
#         )
#     return JSONResponse(
#         status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
#     )


@app.get("/")
async def root():
    """
    An example "Hello world" FastAPI route.
    """
    return {"message": "Hello World"}
