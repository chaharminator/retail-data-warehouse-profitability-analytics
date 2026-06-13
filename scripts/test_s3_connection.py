import boto3

BUCKET_NAME = "retail-data-engineering-project-varun-2026"
PREFIX = "raw/superstore/"

def main():
    s3_client = boto3.client("s3")

    response = s3_client.list_objects_v2(
        Bucket = BUCKET_NAME,
        Prefix = PREFIX
    )

    print("S3 connection successful")
    print("-"*40)

    if "Contents" not in response:
        print("No files found in the specified S3 path.")
        return
    
    print("Files found:")
    for obj in response["Contents"]:
        print(f"-{obj['Key']} | Size: {obj['Size']} bytes")

if __name__ == "__main__":
    main()

