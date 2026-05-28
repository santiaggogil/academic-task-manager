from typing import Optional

from fastapi import (
    APIRouter,
    Depends
)

from sqlalchemy.orm import Session

from app.database import SessionLocal

from app.models.user_model import User

from app.schemas.task_schema import (
    TaskCreate,
    TaskUpdate,
    TaskResponse
)

from app.auth.dependencies import (
    get_current_user
)

from app.services.task_service import (
    create_task_service,
    get_tasks_service,
    get_task_service,
    update_task_service,
    delete_task_service
)

router = APIRouter(
    prefix="/api/tasks",
    tags=["Tasks"]
)


# ==================================
# DATABASE SESSION
# ==================================

def get_db():

    db = SessionLocal()

    try:
        yield db

    finally:
        db.close()


# ==================================
# CREATE TASK
# ==================================

@router.post(
    "",
    response_model=TaskResponse
)
def create_task(
    task: TaskCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(
        get_current_user
    )
):

    return create_task_service(
        task,
        db,
        current_user
    )


# ==================================
# GET ALL TASKS
# SEARCH + FILTER
# ==================================

@router.get(
    "",
    response_model=list[TaskResponse]
)
def get_tasks(

    search: Optional[str] = None,

    status: Optional[str] = None,

    db: Session = Depends(get_db),

    current_user: User = Depends(
        get_current_user
    )
):

    return get_tasks_service(

        db,

        current_user,

        search,

        status
    )


# ==================================
# DASHBOARD STATS
# IMPORTANTE:
# DEBE IR ANTES DE /{task_id}
# ==================================

@router.get("/stats")
def get_task_stats(

    db: Session = Depends(get_db),

    current_user: User = Depends(
        get_current_user
    )
):

    tasks = get_tasks_service(
        db,
        current_user
    )

    total_tasks = len(tasks)

    completed_tasks = len([

        task

        for task in tasks

        if task.status.name.lower()
        == "completed"

    ])

    pending_tasks = (
        total_tasks -
        completed_tasks
    )

    return {

        "total_tasks":
            total_tasks,

        "pending_tasks":
            pending_tasks,

        "completed_tasks":
            completed_tasks
    }


# ==================================
# GET ONE TASK
# ==================================

@router.get(
    "/{task_id}",
    response_model=TaskResponse
)
def get_task(

    task_id: int,

    db: Session = Depends(get_db),

    current_user: User = Depends(
        get_current_user
    )
):

    return get_task_service(

        task_id,

        db,

        current_user
    )


# ==================================
# UPDATE TASK
# ==================================

@router.put(
    "/{task_id}",
    response_model=TaskResponse
)
def update_task(

    task_id: int,

    task_data: TaskUpdate,

    db: Session = Depends(get_db),

    current_user: User = Depends(
        get_current_user
    )
):

    return update_task_service(

        task_id,

        task_data,

        db,

        current_user
    )


# ==================================
# DELETE TASK
# ==================================

@router.delete(
    "/{task_id}"
)
def delete_task(

    task_id: int,

    db: Session = Depends(get_db),

    current_user: User = Depends(
        get_current_user
    )
):

    return delete_task_service(

        task_id,

        db,

        current_user
    )