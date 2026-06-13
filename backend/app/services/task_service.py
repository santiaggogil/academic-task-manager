from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.models.task_model import Task

from app.models.task_status_model import TaskStatus
from app.models.user_model import User
from app.models.category_model import Category
from app.models.priority_model import Priority
from app.models.subject_model import Subject

from app.schemas.task_schema import (
    TaskCreate,
    TaskUpdate
)



def create_task_service(
    task: TaskCreate,
    db: Session,
    current_user: User
):
    # Validate referenced ids exist to return clear 400 errors instead of 500
    if task.subject_id is not None and not db.query(Subject).filter(Subject.id == task.subject_id).first():
        raise HTTPException(status_code=400, detail=f"Subject with id {task.subject_id} does not exist")

    if task.category_id is not None and not db.query(Category).filter(Category.id == task.category_id).first():
        raise HTTPException(status_code=400, detail=f"Category with id {task.category_id} does not exist")

    if task.priority_id is not None and not db.query(Priority).filter(Priority.id == task.priority_id).first():
        raise HTTPException(status_code=400, detail=f"Priority with id {task.priority_id} does not exist")

    if task.status_id is not None and not db.query(TaskStatus).filter(TaskStatus.id == task.status_id).first():
        raise HTTPException(status_code=400, detail=f"Status with id {task.status_id} does not exist")

    new_task = Task(
        title=task.title,
        description=task.description,
        due_date=task.due_date,
        subject_id=task.subject_id,
        category_id=task.category_id,
        priority_id=task.priority_id,
        status_id=task.status_id,
        user_id=current_user.id
    )

    db.add(new_task)

    db.commit()

    db.refresh(new_task)

    return new_task


def get_tasks_service(
    db,
    current_user,
    search=None,
    status=None
):

    query = db.query(Task).filter(
        Task.user_id == current_user.id
    )

    if search:

        query = query.filter(
            Task.title.ilike(
                f"%{search}%"
            )
        )

    if status:

        query = query.join(
            TaskStatus
        ).filter(
            TaskStatus.name == status
        )

    return query.all()

def get_task_service(
    task_id: int,
    db: Session,
    current_user: User
):

    task = db.query(Task).filter(
        Task.id == task_id,
        Task.user_id == current_user.id
    ).first()

    if not task:

        raise HTTPException(
            status_code=404,
            detail="Task not found"
        )

    return task


def update_task_service(

    task_id,
    task_data,
    db,
    current_user
):

    task = db.query(Task).filter(

        Task.id == task_id,

        Task.user_id == current_user.id

    ).first()

    if not task:

        raise HTTPException(

            status_code=404,

            detail="Task not found"
        )

    task.title = task_data.title

    task.description = (
        task_data.description
    )

    task.due_date = (
        task_data.due_date
    )

    task.subject_id = (
        task_data.subject_id
    )

    task.category_id = (
        task_data.category_id
    )

    task.priority_id = (
        task_data.priority_id
    )

    task.status_id = (
        task_data.status_id
    )

    db.commit()

    db.refresh(task)

    return task


def delete_task_service(
    task_id: int,
    db: Session,
    current_user: User
):

    task = get_task_service(
        task_id,
        db,
        current_user
    )

    db.delete(task)

    db.commit()

    return {
        "message": "Task deleted successfully"
    }