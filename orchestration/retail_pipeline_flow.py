from pathlib import Path
import subprocess
import sys

from prefect import flow, task


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DBT_PROJECT_DIR = PROJECT_ROOT / "dbt" / "retail_dbt"


def run_command(command: list[str], working_directory: Path) -> None:
    """
    Runs a shell command, prints stdout/stderr, and raises an error if the command fails.
    """
    print(f"Running command: {' '.join(command)}")
    print(f"Working directory: {working_directory}")

    result = subprocess.run(
        command,
        cwd=working_directory,
        capture_output=True,
        text=True,
    )

    if result.stdout:
        print("STDOUT:")
        print(result.stdout)

    if result.stderr:
        print("STDERR:")
        print(result.stderr)

    if result.returncode != 0:
        raise RuntimeError(
            f"Command failed with exit code {result.returncode}: {' '.join(command)}"
        )


@task(name="Ingest S3 data into PostgreSQL raw layer", retries=1)
def run_s3_to_postgres_ingestion() -> None:
    """
    Runs the Python ingestion script that loads raw Superstore data
    from AWS S3 into PostgreSQL raw.superstore_sales.
    """
    run_command(
        [sys.executable, "scripts/ingest_s3_to_postgres.py"],
        PROJECT_ROOT,
    )


@task(name="Run dbt models", retries=1)
def run_dbt_models() -> None:
    """
    Runs dbt models to build staging and mart tables.
    """
    run_command(
        ["dbt", "run"],
        DBT_PROJECT_DIR,
    )


@task(name="Run dbt tests", retries=1)
def run_dbt_tests() -> None:
    """
    Runs dbt tests for staging, dimension, and fact models.
    """
    run_command(
        ["dbt", "test"],
        DBT_PROJECT_DIR,
    )


@flow(name="Retail Data Engineering Pipeline")
def retail_data_pipeline() -> None:
    """
    Orchestrates the full retail data pipeline:
    1. Load raw data from AWS S3 into PostgreSQL
    2. Build staging and mart tables using dbt
    3. Run dbt data quality tests
    """
    run_s3_to_postgres_ingestion()
    run_dbt_models()
    run_dbt_tests()


if __name__ == "__main__":
    retail_data_pipeline()