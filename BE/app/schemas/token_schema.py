from typing import Optional

from pydantic import BaseModel
from .user_schema import UserRead


class Token(BaseModel):
    data: UserRead
    access_token: str
    token_type: str


class TokenPayload(BaseModel):
    sub: Optional[str] = None


class TokenRead(BaseModel):
    access_token: str
    token_type: str
