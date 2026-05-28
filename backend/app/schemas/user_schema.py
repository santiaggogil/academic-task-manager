from pydantic import BaseModel, EmailStr


class UserCreate(BaseModel):

    name: str

    email: EmailStr

    password: str


class UserResponse(BaseModel):

    id: int

    name: str

    email: EmailStr

    class Config:
        from_attributes = True


#EXPLICACIÓN - UserCreate Se usa para: registrar usuarios
#EXPLICACIÓN - UserResponse Se usa para: responder al frontend 