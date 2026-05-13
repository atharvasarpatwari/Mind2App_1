from fastapi import APIRouter

router = APIRouter(prefix="/orders")

@router.post("/checkout")
def checkout():
    return {"payment_url": "https://example.com/payment"}
