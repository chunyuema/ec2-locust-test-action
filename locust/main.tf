provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "wolf_load_test_server_dev" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  tags          = { Name = "Wolf Load Test Dev" }
  user_data     = file("./locust_test.sh")
}
