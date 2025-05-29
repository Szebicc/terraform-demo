resource "aws_ecr_repository" "this" {
  name = "${var.project_name}-ecr"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project_name}-ecr" 
  }
}

resource "terraform_data" "push_images" {
  depends_on = [ aws_ecr_repository.this ]
  provisioner "local-exec" {
    command = <<EOT
        docker logout
        aws ecr get-login-password --region ${var.region} --profile ${var.profile} | docker login --username AWS --password-stdin ${aws_ecr_repository.this.repository_url}
        cd ../server
        docker build -t eks-demo:latest .
        docker tag eks-demo:latest ${aws_ecr_repository.this.repository_url}:eks-demo
        docker push ${aws_ecr_repository.this.repository_url}:eks-demo
    EOT
  }
}