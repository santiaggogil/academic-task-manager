from pydantic import BaseModel


class PriorityBase(BaseModel):

    name: str


class PriorityResponse(PriorityBase):

    id: int

    class Config:
        from_attributes = True