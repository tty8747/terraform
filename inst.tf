resource "aws_instance" "front" {
  ami           = "${var.ami}"
  instance_type = "${var.insttype}"
  key_name = "${aws_key_pair.sshpubkey.id}"
  associate_public_ip_address = true
  cpu_threads_per_core = "1"
  security_groups = ["default"]

  tags {
    Name = "front"
  }
}
