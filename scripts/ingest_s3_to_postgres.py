import os
from io import BytesIO

import boto3
import pandas as pd
import psycopg2
from dotenv import load_dotenv
from psycopg2.extras import execute_values

BUCKET_NAME = "retail-data-engineering-project-varun-2026"
S3_KEY = "raw/superstore/superstore_sales.csv"

def clean_column_name(df: pd.DataFrame) -> pd.DataFrame:
    """
    Convert source column names into database-friendly snake_case names.
    """
    column_mapping = {
        "Row ID": "row_id",
        "Order ID": "order_id",
        "Order Date": "order_date",
        "Ship Date": "ship_date",
        "Ship Mode": "ship_mode",
        "Customer ID": "customer_id",
        "Customer Name": "customer_name",
        "Segment": "segment",
        "Country/Region": "country_region",
        "City": "city",
        "State/Province": "state_province",
        "Postal Code": "postal_code",
        "Region": "region",
        "Product ID": "product_id",
        "Category": "category",
        "Sub-Category": "sub_category",
        "Product Name": "product_name",
        "Sales": "sales",
        "Quantity": "quantity",
        "Discount": "discount",
        "Profit": "profit",
    }
    df = df.rename(columns = column_mapping)
    return df

def read_csv_from_s3() -> pd.DataFrame:
    """
    Read the raw Superstore CSV file from AWS S3 into a pandas DataFrame.
    """

    s3_client = boto3.client("s3")
    response = s3_client.get_object(
        Bucket = BUCKET_NAME,
        Key = S3_KEY
    )

    csv_content = response["Body"].read()

    df = pd.read_csv(BytesIO(csv_content), encoding = "utf-8-sig")

    print("CSV file read successfully from S3")
    print(f"Rows read from S3: {len(df)}")
    print(f"Columns read from S3: {len(df.columns)}")

    return df

def get_database_connection():
    """
    Create PostgreSQL database connection using environment variables.
    """
    load_dotenv()

    connection = psycopg2.connect(
        host = os.getenv("DB_HOST"),
        port = os.getenv("DB_Port"),
        dbname = os.getenv("DB_NAME"),
        user = os.getenv("DB_USER"),
        password = os.getenv("DB_PASSWORD"),
    )

    return connection

def load_to_postgres(df: pd.DataFrame) -> None:
    """
    Load DataFrame records into raw.superstore_sales table.
    """
    columns = [
        "row_id",
        "order_id",
        "order_date",
        "ship_date",
        "ship_mode",
        "customer_id",
        "customer_name",
        "segment",
        "country_region",
        "city",
        "state_province",
        "postal_code",
        "region",
        "product_id",
        "category",
        "sub_category",
        "product_name",
        "sales",
        "quantity",
        "discount",
        "profit",
    ]

    df = df[columns]
    records = [tuple(row) for row in df.to_numpy()]

    insert_query = """
        INSERT INTO raw.superstore_sales (
            row_id,
            order_id,
            order_date,
            ship_date,
            ship_mode,
            customer_id,
            customer_name,
            segment,
            country_region,
            city,
            state_province,
            postal_code,
            region,
            product_id,
            category,
            sub_category,
            product_name,
            sales,
            quantity,
            discount,
            profit
        )
        VALUES %s
    """

    connection = get_database_connection()

    try:
        cursor = connection.cursor()

        cursor.execute("TRUNCATE TABLE raw.superstore_sales;")
        execute_values(cursor, insert_query, records)

        connection.commit()

        cursor.close()
        connection.close()

        print("Data loaded successfully into PostgreSQL")
        print(f"Rows attempted from Python: {len(records)}")

        verification_connection = get_database_connection()
        verification_cursor = verification_connection.cursor()

        verification_cursor.execute("SELECT COUNT(*) FROM raw.superstore_sales;")
        db_row_count = verification_cursor.fetchone()[0]

        verification_cursor.execute("SELECT current_database();")
        current_database = verification_cursor.fetchone()[0]

        verification_cursor.execute("SELECT inet_server_addr(), inet_server_port();")
        server_info = verification_cursor.fetchone()

        verification_cursor.close()
        verification_connection.close()

        print(f"Rows verified after commit: {db_row_count}")
        print(f"Connected database: {current_database}")
        print(f"PostgreSQL server info: {server_info}")

    except Exception as error:
        connection.rollback()
        connection.close()
        print("Error loading data into PostgreSQL")
        raise error

def main():
    df = read_csv_from_s3()
    df = clean_column_name(df)
    load_to_postgres(df)

if __name__ == "__main__":
    main()