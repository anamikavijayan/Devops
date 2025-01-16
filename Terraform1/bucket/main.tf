# Terraform provider for AWS
provider "aws" {
  region = "ap-south-1"  # Update with your region
}

# Create an S3 bucket with an ACL
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-anu-o1"  # Replace with a globally unique name
  acl    = "private"  # Set the bucket ACL (options: private, public-read, authenticated-read, etc.)

  tags = {
    Name        = "My S3 Bucket"
    Environment = "production"
  }
}

# Set the ACL for an object inside the S3 bucket
resource "aws_s3_object" "my_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "my-object.txt"
  acl    = "public-read"  # Set the object ACL (options: private, public-read, etc.)
  content = "Hello, world!"  # Content of the object
}

# Alternatively, you can manage the ACL of the bucket using aws_s3_bucket_acl resource
resource "aws_s3_bucket_acl" "my_bucket_acl" {
  bucket = aws_s3_bucket.my_bucket.bucket

  access_control_policy {
    grants = [
      {
        grantee {
          type        = "CanonicalUser"
          id          = "arn:aws:iam::123456789012:user/SomeUser"  # Replace with actual user ARN
        }
        permission = "FULL_CONTROL"
      },
      {
        grantee {
          type        = "Group"
          uri         = "http://acs.amazonaws.com/groups/global/AllUsers"  # Grants access to everyone
        }
        permission = "READ"
      }
    ]
    owner {
      id = "arn:aws:iam::987654321098:user/MyOwner"  # Replace with your bucket owner's IAM ARN
    }
  }
}


