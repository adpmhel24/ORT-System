from sqlmodel.ext.asyncio.session import AsyncSession
from app import crud
from app.core.config import settings
from app.schemas.user_schema import UserCreate

# from app.schemas.object_type_schema import IObjectTypeCreate
# from app.schemas.account_type_schema import IAccountTypeCreate
# from app.schemas.gl_category_schema import IGlCategoryCreate
# from app.schemas.series_schema import ISeriesCreate


users: list[dict[str, str | UserCreate]] = [
    {
        "data": UserCreate(
            fullname="Admin",
            password=settings.FIRST_SUPERUSER_PASSWORD,
            email=settings.FIRST_SUPERUSER_EMAIL,
            is_superuser=True,
        ),
    }
]


# object_types: list[IObjectTypeCreate] = [
#     IObjectTypeCreate(code="AP", description="AP Invoice"),
#     IObjectTypeCreate(code="AR", description="AR Invoice"),
#     IObjectTypeCreate(code="IP", description="Incoming Payment"),
#     IObjectTypeCreate(code="OP", description="Outgoing Payment"),
#     IObjectTypeCreate(code="JE", description="Journal Entry"),
#     IObjectTypeCreate(code="PCFR", description="PCF Request"),
#     IObjectTypeCreate(code="PCFE", description="PCF Expense"),
#     IObjectTypeCreate(code="CADV", description="Cash Advance"),
#     IObjectTypeCreate(code="CRET", description="Cash Return"),
#     IObjectTypeCreate(code="CM", description="Credit Memo"),
#     IObjectTypeCreate(code="DM", description="Debit Memo"),
#     IObjectTypeCreate(code="InvIn", description="Inventory In"),
#     IObjectTypeCreate(code="InvOut", description="Inventory Out"),
#     IObjectTypeCreate(code="PEC", description="Period End Closing"),
# ]


async def init_db(db_session: AsyncSession) -> None:
    current_user = None

    for user in users:
        current_user = await crud.user.get_by_email(
            email=user["data"].email, db_session=db_session
        )

        if not current_user:

            await crud.user.create_with_role(obj_in=user["data"], db_session=db_session)

    # await crud.auth_obj.create(created_by_id=current_user.id, db_session=db_session)
