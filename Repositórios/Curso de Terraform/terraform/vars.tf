variable "imagens" {
    type = map

    default = {
        "us-east-1" = "ami-04505e74c0741db8d"
        "us-east-2" = "ami-0fb653ca2d3203ac1"
    }
}

variable "ips" {
    type = list
    default = ["186.220.198.120/32", "187.220.198.120/32"]
}

variable "instancia" {
    type = map

    default = {
        "t2micro" = "t2.micro"
    }
}

variable "key_name" {
    default = "terraform-aws"
}