from fastapi import FastAPI

from app.database import engine, Base

from app.models.user_model import User
from app.models.subject_model import Subject
from app.models.category_model import Category
from app.models.priority_model import Priority
from app.models.task_status_model import TaskStatus
from app.models.task_model import Task
from app.models.task_history_model import TaskHistory

from app.routes.auth_routes import router as auth_router

from app.routes.task_routes import router as task_router

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Academic Task Manager API"
)

app.include_router(auth_router)
app.include_router(task_router)

@app.get("/")
def root():

    return {
        "message": "Academic Task Manager API"
    }