resource "aws_instance" "front" {
  ami                         = "${var.ami}"
  instance_type               = "${var.insttype}"
  key_name                    = "${aws_key_pair.sshpubkey.id}"
  associate_public_ip_address = true
  cpu_threads_per_core        = "1"
  security_groups             = ["${aws_security_group.front.name}"]
  tags {
    Name                      = "front"
  }
}

resource "aws_instance" "api" {
  ami                         = "${var.ami}"
  instance_type               = "${var.insttype}"
  key_name                    = "${aws_key_pair.sshpubkey.id}"
  associate_public_ip_address = true
  cpu_threads_per_core        = "1"
  security_groups             = ["${aws_security_group.api.name}"]
  tags {
    Name                      = "api"
  }
}

resource "aws_ebs_volume" "volume-front" {
  count             = 1
  availability_zone = "${aws_instance.front.availability_zone}"
  type              = "gp2"
  size              = 1
}

resource "aws_ebs_volume" "volume-api" {
  count             = 1
  availability_zone = "${aws_instance.api.availability_zone}"
  type              = "gp2"
  size              = 1
}

resource "aws_volume_attachment" "volume-attach-front" {
  device_name = "/dev/xvdx" # xvda - занято системой
  instance_id = "${aws_instance.front.id}"
  volume_id   = "${aws_ebs_volume.volume-front.id}"
}

resource "aws_volume_attachment" "volume-attach-api" {
  device_name = "/dev/xvdy" # xvda - занято системой
  instance_id = "${aws_instance.api.id}"
  volume_id   = "${aws_ebs_volume.volume-api.id}"
}

resource "aws_security_group" "front" {
  name        = "front"
  vpc_id      = "vpc-004b4e68"
}

resource "aws_security_group" "api" {
  name        = "api"
  vpc_id      = "vpc-004b4e68"
}

resource "aws_security_group_rule" "ssh_access" {
  count             = "${length(var.ssh_port)}"
  type              = "ingress"
  from_port         = "${element(var.ssh_port, count.index)}"
  to_port           = "${element(var.ssh_port, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.front.id}"
}

resource "aws_security_group_rule" "front_open_nginx" {
  count             = "${length(var.front_open_nginx)}"
  type              = "ingress"
  from_port         = "${element(var.front_open_nginx, count.index)}"
  to_port           = "${element(var.front_open_nginx, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.front.id}"
}

resource "aws_security_group_rule" "out_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.front.id}"
}
