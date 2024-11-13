resource "aws_instance" "web" {
  count                     = 2  # length(var.ec2_names)  # Create instances based on the length of ec2_names
  ami                       = "ami-08eb150f611ca277f"  # Specify the AMI
  instance_type             = "t3.micro"  # Free Tier eligible instance type
  associate_public_ip_address = true  # Associate a public IP with the instance
  vpc_security_group_ids    = [var.sg_id]  # Pass the security group ID
  subnet_id                 = var.subnets[count.index]  # Pass subnet ID for each instance
  availability_zone         = data.aws_availability_zones.available.names[count.index]  # Use AZs from data source

  tags = {
    Name = var.ec2_names[count.index]  # Set the instance name
  }
}
resource "aws_internet_gateway" "example" {
  vpc_id = "vpc-0ed2d87f8632c1a8d"  # Use your VPC ID here
}

# Optional: Update your route table to allow public subnet to access the internet.
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id  # Route table for your public subnets
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example.id
}
