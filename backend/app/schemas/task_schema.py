from datetime import datetime

from pydantic import BaseModel

from app.schemas.subject_schema import SubjectResponse
from app.schemas.category_schema import CategoryResponse
from app.schemas.priority_schema import PriorityResponse
from app.schemas.task_status_schema import TaskStatusResponse

from pydantic import BaseModel, Field
from datetime import datetime

class TaskCreate(BaseModel):

    title: str = Field(
        min_length=3,
        max_length=100
    )

    description: str = Field(
        min_length=3,
        max_length=500
    )

    due_date: datetime

    subject_id: int

    category_id: int

    priority_id: int

    status_id: int

class TaskUpdate(BaseModel):

    title: str = Field(
        min_length=3,
        max_length=100
    )

    description: str = Field(
        min_length=3,
        max_length=500
    )

    due_date: datetime

    subject_id: int

    category_id: int

    priority_id: int

    status_id: int


class TaskResponse(BaseModel):

    id: int

    title: str

    description: str

    due_date: datetime

    # IDs IMPORTANTES
    subject_id: int

    category_id: int

    priority_id: int

    status_id: int

    # OBJETOS COMPLETOS
    subject: SubjectResponse

    category: CategoryResponse

    priority: PriorityResponse

    status: TaskStatusResponse

    class Config:
        from_attributes = True