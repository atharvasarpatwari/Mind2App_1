from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .database import SessionLocal
from .models import CartItem

router = APIRouter(prefix="/cart")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/add")
def add_to_cart(user_id: int, product_id: int, db: Session = Depends(get_db)):
    item = CartItem(user_id=user_id, product_id=product_id, quantity=1)
    db.add(item)
    db.commit()
    return {"message": "Added to cart"}

@router.get("/{user_id}")
def get_cart(user_id: int, db: Session = Depends(get_db)):
    return db.query(CartItem).filter(CartItem.user_id == user_id).all()
