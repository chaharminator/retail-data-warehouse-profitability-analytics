import pandas as pd
from pathlib import Path

DATA_PATH = Path("data/raw/superstore_sales.csv")

def main():
    if not DATA_PATH.exists():
        raise FileNotFoundError(f"Dataset not found at: {DATA_PATH}")
    
    df = pd.read_csv(DATA_PATH, encoding="utf-8-sig")

    print("Dataset Loaded Successfully")
    print("-"*40)

    print(f"Rows:{df.shape[0]}")
    print(f"Columns:{df.shape[1]}")

    print("\nColumn names:")
    for column in df.columns:
        print(f"- {column}")

    print("\nFirst 5 rows:")
    print(df.head())

    print("\nMissing values:")
    print(df.isnull().sum())

    print("\nDuplicate rows:")
    print(df.duplicated().sum())

    print("\nData types:")
    print(df.dtypes)

if "__name__ = __main__":
    main()