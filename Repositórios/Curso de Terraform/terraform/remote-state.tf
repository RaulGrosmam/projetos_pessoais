/*
terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "Curso_Terraform"

        workspaces {
            name = "Cursao_Top"
        }
    }
}
          */

terraform {
  cloud {
    organization = "Curso_Terraform"

    workspaces {
      name = "teste"
    }
  }
}