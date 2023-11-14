
provider "aws" {
  region = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_key_pair" "maestro_ssh" {
  key_name   = "maestro_ssh"
  public_key =  var.aws_ssh_key
}

resource "aws_vpc" "root_vpc" {
  cidr_block = "16.16.0.0/16"
  tags = {
    Name = "maestro-vpc"
  }
 // lifecycle {
 //   prevent_destroy = true
 // }
}

resource "aws_subnet" "root_sub_a" {
  vpc_id            = aws_vpc.root_vpc.id
  cidr_block        = "16.16.16.0/20"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "maestro_sub_a"
  }

}

resource "aws_subnet" "root_sub_b" {
  vpc_id            = aws_vpc.root_vpc.id
  cidr_block        = "16.16.32.0/20"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "maestro_sub_b"
  }

}


//output "map_subnet_ids" {
//  value = tomap({
 ///   for s in aws_subnet.root_sub : s.availability_zone => s.id
//  })
//}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.root_vpc.id
  tags = {
    Name = "maestro-gt"
  }
}

resource "aws_route_table" "maestro-route-public" {
  vpc_id = aws_vpc.root_vpc.id

  route {
    cidr_block           = aws_vpc.root_vpc.cidr_block
    gateway_id           = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "maestro-route"
  }
}

resource "aws_route_table_association" "maestro-route-add_a" {
  subnet_id      = aws_subnet.root_sub_a.id
  route_table_id = aws_route_table.maestro-route-public.id
}
resource "aws_route_table_association" "maestro-route-add_b" {
  subnet_id      = aws_subnet.root_sub_b.id
  route_table_id = aws_route_table.maestro-route-public.id
}



resource "aws_eip" "lb" {
  count = length(local.vm_settings)
  instance = aws_instance.web-nginx[count.index].id
  domain   = "vpc"

}


resource "aws_security_group" "maestro_elb_group" {
  name        = "maestro_elb_group"
  description = "Allow HTTP to ELB"
  vpc_id      = aws_vpc.root_vpc.id

  ingress {
    description      = "Load Balancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "Load Balancer gatsby"
    from_port        = 90
    to_port          = 90
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    description      = "Load Balancer"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.root_vpc.cidr_block]
  }
  egress {
    description      = "Load Balancer gatsby"
    from_port        = 90
    to_port          = 90
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.root_vpc.cidr_block]
  }
  tags = {
    Name = "maestro_elb_group"
  }
}

resource "aws_security_group" "maestro_web_group" {
  name        = "maestro_web_group"
  description = "Allow ssh and elb"
  vpc_id      = aws_vpc.root_vpc.id

  egress {
    description      = "local"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "maestro_web_group"
  }
}



resource "aws_security_group_rule" "maestro_web_group_allow_ssh" {
  type              = "ingress"
  description      = "ssh"
  from_port         = 22 // first part of port range 
  to_port           = 22 // second part of port range
  protocol          = "tcp" // Protocol, could be "tcp" "udp" etc. 
  security_group_id = aws_security_group.maestro_web_group.id // Which group to attach it to
  cidr_blocks       = ["45.11.137.107/32"]
}

resource "aws_security_group_rule" "maestro_web_group_allow_elb" {
  type              = "ingress"
  description      = "elb"
  from_port         = 0 // first part of port range 
  to_port           = 65535 // second part of port range
  protocol          = "-1" // Protocol, could be "tcp" "udp" etc. 
  security_group_id = aws_security_group.maestro_web_group.id // Which group to attach it to
  source_security_group_id = aws_security_group.maestro_elb_group.id // Which group to specify as source
}


resource "aws_security_group_rule" "maestro_web_group_allow_local" {
  type              = "ingress"
  description      = "local"
  from_port         = 0 // first part of port range 
  to_port           = 65535 // second part of port range
  protocol          = "-1" // Protocol, could be "tcp" "udp" etc. 
  security_group_id = aws_security_group.maestro_web_group.id // Which group to attach it to
  source_security_group_id = aws_security_group.maestro_web_group.id // Which group to specify as source
}




resource "aws_instance" "web-nginx" {
  count = length(local.vm_settings)
  disable_api_termination = false
  ami           = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.maestro_ssh.key_name
  tags = {
    Name = "${local.vm_settings[count.index].name}"
    foo = "bar"
  }
  security_groups = [aws_security_group.maestro_web_group.id]

  subnet_id     = local.vm_settings[count.index].subnet_id
  lifecycle {

    ignore_changes        = [tags,security_groups]
  }

}




// ----------------------------------------------ELB Section----------------------------------

resource "aws_lb" "maestro_elb" {
  name               = "maestro-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.maestro_elb_group.id]
  subnet_mapping {
    subnet_id     = aws_subnet.root_sub_a.id
   
  }

  subnet_mapping {
    subnet_id     = aws_subnet.root_sub_b.id

  }




  tags = {
    Environment = "production"
    Name = "maestro_elb"
  }
}

resource "aws_lb_target_group" "maestro_target_elb" {
  name     = "maestro-target-elb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.root_vpc.id
}

resource "aws_lb_target_group" "maestro_target_elb_gatsby" {
  name     = "maestro-target-elb-gatsby"
  port     = 90
  protocol = "HTTP"
  vpc_id   = aws_vpc.root_vpc.id
}

locals {
  att_004 = join("_", aws_instance.web-nginx[*].id )
}


resource "aws_lb_target_group_attachment" "maestro_target_elb_at" {
  depends_on = [ aws_instance.web-nginx ]

  count      = length( aws_instance.web-nginx )

  target_group_arn = aws_lb_target_group.maestro_target_elb.arn
  target_id        = split("_", local.att_004)[count.index]
  port             = 80
}

resource "aws_lb_target_group_attachment" "maestro_target_elb_gat" {
  depends_on = [ aws_instance.web-nginx ]

  count      = length( aws_instance.web-nginx )

  target_group_arn = aws_lb_target_group.maestro_target_elb_gatsby.arn
  target_id        = split("_", local.att_004)[count.index]
  port             = 90
}


resource "aws_lb_listener" "maestro_front_end" {
  load_balancer_arn = aws_lb.maestro_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.maestro_target_elb.arn
  }
}

resource "aws_lb_listener" "maestro_front_gat" {
  load_balancer_arn = aws_lb.maestro_elb.arn
  port              = "90"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.maestro_target_elb_gatsby.arn
  }
}


// DATABASE section

resource "aws_db_subnet_group" "maestro_sub_database" {
  name       = "maestro_sub_database"
  subnet_ids = [aws_subnet.root_sub_a.id, aws_subnet.root_sub_b.id]

  tags = {
    Name = "maestro_sub_database"
  }
}
resource "aws_db_parameter_group" "maestro_parameter_group" {
  name   = "maestro-rds-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
resource "aws_db_instance" "maestro_db" {

  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine               = "mysql"
  engine_version       = "8.0.33"
  username               = var.database_user
  password               = var.database_pass
  db_name                = var.database_name
  db_subnet_group_name   = aws_db_subnet_group.maestro_sub_database.name
  vpc_security_group_ids = [aws_security_group.maestro_web_group.id]
  parameter_group_name   = aws_db_parameter_group.maestro_parameter_group.name
  //publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = true
  
}

data "aws_db_instance" "maestro_db_host" {
  db_instance_identifier = aws_db_instance.maestro_db.id
}

data "aws_lb" "maestro_elb_info" {
  arn  = aws_lb.maestro_elb.arn
  name = aws_lb.maestro_elb.name
}




output "ec2_global_ips" {
  value = ["${aws_eip.lb.*.public_ip}"]
}

output "maestro_db_host" {
  value = [data.aws_db_instance.maestro_db_host.address]
}

output "maestro_elb_name" {
  value = [data.aws_lb.maestro_elb_info.dns_name]
}

resource "local_file" "inventoryhosts" {

  content = templatefile("template_ansible.tpl", {ubuntu_hosts ="${aws_instance.web-nginx.*.public_ip}", db = "${data.aws_db_instance.maestro_db_host.address}",db_pass=var.database_pass, db_user=var.database_user, db_name=var.database_name , dns_name=data.aws_lb.maestro_elb_info.dns_name})
  filename = "hosts"

  provisioner "local-exec" {
    command = "ansible-playbook -i hosts wordpress/playbook.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
  }
}