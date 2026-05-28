from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime,
    ForeignKey
)

from sqlalchemy.sql import func

from sqlalchemy.orm import relationship

from app.database import Base


class TaskHistory(Base):

    __tablename__ = "task_history"

    id = Column(Integer, primary_key=True, index=True)

    action = Column(String, nullable=False)

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now()
    )

    task_id = Column(
        Integer,
        ForeignKey("tasks.id")
    )

    task = relationship(
        "Task",
        back_populates="history"
    )