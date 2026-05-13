from pydantic import BaseModel

class UserCreate(BaseModel):
    name: str
    email: str
    password: str

class CategoryCreate(BaseModel):
    name: str

class ProductCreate(BaseModel):
    title: str
    price: float
    category_id: int
