from fastapi import FastAPI, HTTPException
import json
from random import randrange

app = FastAPI(redoc_url=None, docs_url=None)


@app.get("/")
def read_root():
    return {"Hi": "There!"}


@app.get("/data")
def read_root():
    if randrange(0, 9) in (9, 4):
        return HTTPException(status_code=500, detail="Infernal Server Error.")
    with open("./resp.json", "r") as j:
        resp = json.load(j)
        return resp

