import boto3
import psycopg2
from io import StringIO
from dotenv import load_dotenv
import os
from pathlib import Path

project_root = Path(__file__).resolve().parents[2]
load_dotenv(project_root / ".env")

AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_ENDPOINT_URL = os.getenv("AWS_ENDPOINT_URL")

POSTGRES_HOST = os.getenv("POSTGRES_HOST")
POSTGRES_PORT = os.getenv("POSTGRES_PORT")
POSTGRES_DB = os.getenv("POSTGRES_DB")
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")

sources_list = ['listings', 'bookings', 'hosts']

conn = psycopg2.connect(
    host=POSTGRES_HOST,
    port=POSTGRES_PORT,
    dbname=POSTGRES_DB,
    user=POSTGRES_USER,
    password=POSTGRES_PASSWORD
)

cur = conn.cursor()

s3 = boto3.client(
    "s3",
    endpoint_url=AWS_ENDPOINT_URL,
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
)

def load_table(table_name, s3_source_name):
    
    obj = s3.get_object(
        Bucket="de-pet-project",
        Key=f"source/{s3_source_name}.csv"
    )

    csv_data = obj["Body"].read().decode("utf-8")

    cur.copy_expert(
        f"""
        COPY staging.{table_name}
        FROM STDIN
        WITH (FORMAT CSV, HEADER TRUE)
        """,
        StringIO(csv_data)
    )

for source in sources_list:
    load_table(source, source)

conn.commit()
cur.close()
conn.close()