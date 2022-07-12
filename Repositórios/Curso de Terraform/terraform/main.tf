resource "aws_instance" "instancia_teste" {
    count = 3
    ami = "ami-04505e74c0741db8d"
    instance_type = var.instancia["t2micro"]
    key_name = var.key_name
    tags = {
        Name = "instancia_teste${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.liberar_ssh.id}"]
}

resource "aws_instance" "testezaobonito" {
    ami = "ami-04505e74c0741db8d"
    instance_type = var.instancia["t2micro"]
    key_name = var.key_name
    tags = {
        Name = "testezaobonito"
    }
    vpc_security_group_ids = ["${aws_security_group.liberar_ssh.id}"]
}

resource "aws_instance" "testezaobonitov2" {
    ami = var.imagens["us-east-1"]
    instance_type = var.instancia["t2micro"]
    key_name = var.key_name
    tags = {
        Name = "testezaobonitov2"
    }
    vpc_security_group_ids = ["${aws_security_group.liberar_ssh.id}"]
    depends_on = [aws_s3_bucket.testezaobonitobucketv2]
}

resource "aws_instance" "outraregiao" {
    provider = aws.us-east-2
    ami = var.imagens["us-east-2"]
    instance_type = var.instancia["t2micro"]
    key_name = var.key_name
    tags = {
        Name = "outraregiao"
    }
    vpc_security_group_ids = ["${aws_security_group.liberar_ssh_outraregiao.id}"]
    depends_on = [aws_dynamodb_table.databasebonitao]
}

resource "aws_instance" "outraregiaov2" {
    provider = aws.us-east-2
    ami = var.imagens["us-east-2"]
    instance_type = var.instancia["t2micro"]
    key_name = var.key_name
    tags = {
        Name = "outraregiaov2"
    }
    vpc_security_group_ids = ["${aws_security_group.liberar_ssh_outraregiao.id}"]
}
