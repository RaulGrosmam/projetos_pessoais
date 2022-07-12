output "ips" {
    value = "${aws_instance.testezaobonito.public_ip}"
}