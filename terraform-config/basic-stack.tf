provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "eu-west-1"
}

resource "aws_security_group" "web-node" {
	name = "web-node"
	description = "Allow all inbound traffic"

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["136.243.157.121/32"]
	}

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["136.243.157.121/32"]
	}		

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_security_group" "app-node" {
        name = "app-node"
        description = "Allow all inbound traffic"

        ingress {
                from_port = 8080
                to_port = 8080
                protocol = "tcp"
                cidr_blocks = ["${aws_instance.web-node.public_ip}/32"]
        }

 	ingress {
                from_port = 8080
                to_port = 8080
                protocol = "tcp"
                cidr_blocks = ["136.243.157.121/32"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["136.243.157.121/32"]
        }

	ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["52.49.146.13/32"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}


resource "aws_instance" "web-node" {
	ami = "ami-0821927b"
	instance_type = "t1.micro"
	key_name = "misc.keithrogers.co.uk"
	security_groups = ["${aws_security_group.web-node.name}"]
}

resource "aws_instance" "app-node-1" {
        ami = "ami-eb239098"
        instance_type = "t2.micro"
        key_name = "misc.keithrogers.co.uk"
        security_groups = ["${aws_security_group.app-node.name}"]
}

resource "aws_instance" "app-node-2" {
        ami = "ami-eb239098"
        instance_type = "t2.micro"
        key_name = "misc.keithrogers.co.uk"
        security_groups = ["${aws_security_group.app-node.name}"]
}

resource "aws_route53_record" "www" {
	zone_id = "Z164FRIYAHB8LT"
	name = "www.devopper.co.uk"
	type = "A"
	ttl = "300"
	records = ["${aws_instance.web-node.public_ip}"]
}

resource "aws_route53_record" "app-node1" {
        zone_id = "Z164FRIYAHB8LT"
        name = "app-node1.devopper.co.uk"
        type = "A"
        ttl = "300"
        records = ["${aws_instance.app-node-1.public_ip}"]
}

resource "aws_route53_record" "app-node2" {
        zone_id = "Z164FRIYAHB8LT"
        name = "app-node2.devopper.co.uk"
        type = "A"
        ttl = "300"
        records = ["${aws_instance.app-node-2.public_ip}"]
}
