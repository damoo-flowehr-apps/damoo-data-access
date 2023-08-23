import os
import logging
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel

from azure_logging import initialize_logging
from azure_log_exporter import setup_azurelog_exporter

# create the FastAPI app
app = FastAPI()

# figure out where we're running
environment = os.environ.get("ENVIRONMENT", default="dev")

# TODO - only for dev
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"])

@app.get("/api/hello")
def hello():
    return {"response": "hello"}

# serve the static (built) front end files - leave this file at the end else the / route overrides the /api methods
app.mount("/", StaticFiles(directory="../ui/build", html = True), name="Data Access Request")