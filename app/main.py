import secrets
from src.aws_secret import get_secret
from src.api_functions import post_hash_data_to_s3, get_hash_data_from_s3

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBasic, HTTPBasicCredentials

app = FastAPI()
security = HTTPBasic()

def authorize(credentials: HTTPBasicCredentials = Depends(security)):
    api_credentials = get_secret()
    api_username = secrets.compare_digest(credentials.username, api_credentials["username"])
    api_password = secrets.compare_digest(credentials.password, api_credentials["password"])
    if not (api_username and api_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
        )
    return True

# Define your other GET and POST endpoints here
@app.get("/")
def get_methods():
    return {"message": "GET /get_hash_data endpoint"}

@app.post("/")
def post_methods():
    return {"message": "POST /post_hash_data endpoint"}

@app.post("/post_hash_data", dependencies=[Depends(authorize)])
def post_hash_data(firstName: str, lastName: str, date_of_birth: str):

    return post_hash_data_to_s3(firstName, lastName, date_of_birth)

@app.get("/get_hash_data", dependencies=[Depends(authorize)])
def get_hash_data(hash_value: str):

    return get_hash_data_from_s3(hash_value)
