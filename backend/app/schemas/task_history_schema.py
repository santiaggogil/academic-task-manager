from datetime import datetime

from pydantic import BaseModel


class TaskHistoryResponse(BaseModel):

    id: int

    action: str

    created_at: datetime

    class Config:
        from_attributes = True