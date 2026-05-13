from fastapi import APIRouter, Depends, UploadFile, File, Form
from sqlalchemy.orm import Session
import shutil
from .database import SessionLocal
from .models import Product

router = APIRouter(prefix="/products")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/")
def add_product(
    title: str = Form(...),
    price: float = Form(...),
    category_id: int = Form(...),
    image: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    path = f"uploads/{image.filename}"
    with open(path, "wb") as f:
        shutil.copyfileobj(image.file, f)

    p = Product(title=title, price=price, image=path, category_id=category_id)
    db.add(p)
    db.commit()
    return p

@router.get("/category/{cat_id}")
def get_products(cat_id: int, db: Session = Depends(get_db)):
    return db.query(Product).filter(Product.category_id == cat_id).all()
