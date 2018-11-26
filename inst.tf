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
##device_name = "/dev/xvda"
  device_name = "/dev/sdf"
  instance_id = "${aws_instance.front.id}"
  volume_id   = "${aws_ebs_volume.volume-front.id}"
}

resource "aws_volume_attachment" "volume-attach-api" {
# device_name = "/dev/xvdb"
  device_name = "/dev/sdf"
  instance_id = "${aws_instance.api.id}"
  volume_id   = "${aws_ebs_volume.volume-api.id}"
}

resource "aws_security_group" "front" {
  name        = "front"
}

resource "aws_security_group" "api" {
  name        = "api"
}

resource "aws_security_group_rule" "ssh_access" {
  count             = "${length(var.ssh_port)}"
  type              = "ingress"
  from_port         = "${element(var.ssh_port, count.index)}"
  to_port           = "${element(var.ssh_port, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.front.id}"
}
