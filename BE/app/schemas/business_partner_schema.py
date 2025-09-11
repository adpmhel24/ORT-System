from app.models.business_partner_model import BusinessPartnerBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class BusinessPartnerCreate(BusinessPartnerBase):
    pass

class BusinessPartnerRead(UpdatedSchema, CreatedSchema, IdSchema, BusinessPartnerBase):
    pass

class BusinessPartnerUpdate(BusinessPartnerBase):
    pass
