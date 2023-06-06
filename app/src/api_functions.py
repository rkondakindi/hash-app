import boto3
import json
import hashlib
import botocore

def generate_hash(first_name, last_name, date_of_birth):
    # Concatenate the input values
    data = first_name + last_name + date_of_birth

    # Create a SHA-256 hash object
    sha256_hash = hashlib.sha256()

    # Convert the concatenated data to bytes and hash it
    sha256_hash.update(data.encode('utf-8'))

    # Get the hexadecimal representation of the hash
    hash_value = sha256_hash.hexdigest()

    return hash_value


def post_hash_data_to_s3(firstName: str, lastName: str, date_of_birth: str):
    # Validate the date formate
    # validate_date(date_of_birth)
    hash_key = generate_hash(firstName, lastName, date_of_birth)
    data_dict = {
        hash_key:[firstName, lastName, date_of_birth]
    }

    aws_obj = aws_resources()
    existing_data = aws_obj.get_data()

    # Append the new data to the existing dictionary
    existing_data.update(data_dict)

    # Update the hash data to the S3 object
    aws_obj.put_data(existing_data)
    return hash_key


def get_hash_data_from_s3(hash_value: str):

    aws_obj = aws_resources()
    existing_data = aws_obj.get_data()
    try:
        text_values = existing_data[hash_value]
    except Exception :
        return "Matching Hash key Not Found"
    print("text values are ", text_values)

    return text_values

class aws_resources():
    def __init__(self) -> None:
        self.bucket_name = "my-birthday-hash-app"
        self.file_name = "hash_dictionary.json"
        self.s3 =  boto3.client('s3')

    def get_data(self):
        # Retrieve the existing dictionary from S3
        try:
            response = self.s3.get_object(Bucket=self.bucket_name, Key=self.file_name)
            existing_data = json.loads(response["Body"].read().decode())
        except botocore.exceptions.ClientError as error:
            existing_data={}
            if error.response['Error']['Code'] == 'NoSuchKey':
                print('No such object')
            else: # Unknown exception
                print(error.response)
        return existing_data
    
    def put_data(self, data):

        try:
            response = self.s3.put_object(
                Body=json.dumps(data),
                Bucket=self.bucket_name,
                Key=self.file_name
            )

            # Validate the response
            if response['ResponseMetadata']['HTTPStatusCode'] == 200:
                print("File uploaded successfully.")
            else:
                print("File upload failed.")
        except botocore.exceptions.ClientError as error:
            print(error.response)
        return 