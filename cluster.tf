resource "aws_db_instance" "mysql" {
  allocated_storage    = 1
  db_name              = "roboshop-${var.ENV}-mysql"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin1"
  password             = "roboshop1"
  parameter_group_name = aws_db_parameter_group.mysql-pg.name
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.mysql-subnet-group.name
}

resource "aws_db_parameter_group" "mysql-pg" {
  name   = "roboshop-${var.ENV}-mysql-pg"
  family = "mysql5.7"
}

resource "aws_db_subnet_group" "mysql-subnet-group" {
  name = "roboshop-${var.ENV}-mysql-subnet-group"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS]

  tags = {
    Name = "roboshop-${var.ENV}-mysql-subnet-group"
  }
  
}