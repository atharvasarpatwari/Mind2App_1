from fastapi import FastAPI
from .database import Base, engine
from . import users, categories, products, cart, orders

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(users.router)
app.include_router(categories.router)
app.include_router(products.router)
app.include_router(cart.router)
app.include_router(orders.router)
