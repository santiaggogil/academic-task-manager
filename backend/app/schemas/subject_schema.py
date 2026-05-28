from pydantic import BaseModel


class SubjectBase(BaseModel):

    name: str


class SubjectResponse(SubjectBase):

    id: int

    class Config:
        from_attributes = True