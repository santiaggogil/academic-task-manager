from fastapi import (
    APIRouter,
    Depends
)

from sqlalchemy.orm import Session

from app.database import SessionLocal

from app.schemas.user_schema import (
    UserCreate,
    UserResponse
)

from app.schemas.auth_schema import (
    LoginRequest,
    TokenResponse
)

from app.services.auth_service import (
    register_user,
    login_user
)

router = APIRouter(
    prefix="/api",
    tags=["Authentication"]
)


def get_db():

    db = SessionLocal()

    try:
        yield db

    finally:
        db.close()


@router.post(
    "/register",
    response_model=UserResponse
)

def register(
    user: UserCreate,
    db: Session = Depends(get_db)
):

    return register_user(
        user,
        db
    )


@router.post(
    "/login",
    response_model=TokenResponse
)

def login(
    credentials: LoginRequest,
    db: Session = Depends(get_db)
):

    return login_user(
        credentials,
        db
    )