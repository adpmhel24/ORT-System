from typing import List
from ..models.empl_position_model import EmplPositionBase, LogEmplPositionBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema


class EmplPositionCreate(EmplPositionBase):
    pass


class EmplPositionUpdate(EmplPositionBase):
    pass


class EmplPositionRead(EmplPositionBase):
    logNotes: List["LogEmplPositionRead"] = []


class LogEmplPositionCreate(LogEmplPositionBase):
    pass


class LogEmplPositionRead(IdSchema, LogEmplPositionBase):
    pass
