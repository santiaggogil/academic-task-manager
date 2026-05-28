from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from app.database import Base


class TaskStatus(Base):

    __tablename__ = "task_status"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(String, nullable=False)

    tasks = relationship("Task", back_populates="status")