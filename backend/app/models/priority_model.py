from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from app.database import Base


class Priority(Base):

    __tablename__ = "priorities"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(String, nullable=False)

    tasks = relationship("Task", back_populates="priority")