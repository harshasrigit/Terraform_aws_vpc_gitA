resource "aws_instance" "web" {
  count                     = 2  # length(var.ec2_names)  # Create instances based on the length of ec2_names
  ami                       = "ami-08eb150f611ca277f"  # Specify the AMI
  instance_type             = "t3.micro"  # Free Tier eligible instance type
  associate_public_ip_address = true  # Associate a public IP with the instance
  vpc_security_group_ids    = [var.sg_id]  # Pass the security group ID
  subnet_id                 = var.subnets[0,1]  # Pass subnet ID for each instance
  availability_zone         = data.aws_availability_zones.available.names[0,1]  # Use AZs from data source

  tags = {
    Name = var.ec2_names[0,1]  # Set the instance name
  }
}
