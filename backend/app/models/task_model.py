from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    DateTime,
    ForeignKey
)

from sqlalchemy.orm import relationship

from app.database import Base


class Task(Base):

    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)

    title = Column(String, nullable=False)

    description = Column(Text)

    due_date = Column(DateTime)

    user_id = Column(Integer, ForeignKey("users.id"))

    subject_id = Column(Integer, ForeignKey("subjects.id"))

    priority_id = Column(Integer, ForeignKey("priorities.id"))

    status_id = Column(Integer, ForeignKey("task_status.id"))

    category_id = Column(Integer, ForeignKey("categories.id"))

    user = relationship("User", back_populates="tasks")

    subject = relationship("Subject", back_populates="tasks")

    priority = relationship("Priority", back_populates="tasks")

    status = relationship("TaskStatus", back_populates="tasks")

    category = relationship("Category", back_populates="tasks")

    history = relationship("TaskHistory", back_populates="task")