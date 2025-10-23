from app.models.personnel_model import PersonnelBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class PersonnelCreate(PersonnelBase):
    pass

class PersonnelRead(UpdatedSchema, CreatedSchema, IdSchema, PersonnelBase):
    pass

class PersonnelUpdate(PersonnelBase):
    pass
