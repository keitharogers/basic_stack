# Terraform Config

Terraform is used to provision the entire stack which is comprised of the following:

- 1x Nginx Load Balancer
- 1x Jenkins CI Server
- 2x Go Application Nodes

We use Terraform to perform the following actions in AWS:

- Create 4 instances
- Create a security group for each 'type' of instance (web,app,jenkins)
- Add DNS records to route53 (AWS' DNS Service)

The entire process described above is automated by simply running the following command entering your AWS access key and secret key:

```bash
./terraform apply
```

Terraform maintians a state file to keep track of any changes to the infrastructure.

The full stack config for Terraform is shown below:

```
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "eu-west-1"
}

resource "aws_security_group" "web-node" {
	name = "web-node"
	description = "Web Security Group"

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
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
        description = "App Security Group"

 	ingress {
                from_port = 8080
                to_port = 8080
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_security_group" "jenkins-node" {
        name = "jenkins-node"
        description = "Jenkins Security Group"

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "jenkins-node" {
        ami = "ami-4ae05239"
        instance_type = "t1.micro"
        key_name = "misc.keithrogers.co.uk"
        security_groups = ["${aws_security_group.jenkins-node.name}"]
}

resource "aws_route53_record" "www" {
	zone_id = "Z164FRIYAHB8LT"
	name = "www.devopper.co.uk"
	type = "A"
	ttl = "60"
	records = ["${aws_instance.web-node.public_ip}"]
}

resource "aws_route53_record" "app-node1" {
        zone_id = "Z164FRIYAHB8LT"
        name = "app-node1.devopper.co.uk"
        type = "A"
        ttl = "60"
        records = ["${aws_instance.app-node-1.public_ip}"]
}

resource "aws_route53_record" "app-node2" {
        zone_id = "Z164FRIYAHB8LT"
        name = "app-node2.devopper.co.uk"
        type = "A"
        ttl = "60"
        records = ["${aws_instance.app-node-2.public_ip}"]
}

resource "aws_route53_record" "jenkins" {
        zone_id = "Z164FRIYAHB8LT"
        name = "jenkins.devopper.co.uk"
        type = "A"
        ttl = "60"
        records = ["${aws_instance.jenkins-node.public_ip}"]
}
```
