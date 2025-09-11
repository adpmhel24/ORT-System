from models.trip_attachment_model import TripAttachmentBase
from .base_schema import IdSchema, CreatedSchema, UpdatedSchema

class TripAttachmentCreate(TripAttachmentBase):
    pass

class TripAttachmentRead(UpdatedSchema, CreatedSchema, IdSchema, TripAttachmentBase):
    pass

class TripAttachmentUpdate(TripAttachmentBase):
    pass
