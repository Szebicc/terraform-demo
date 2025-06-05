resource "aws_eks_addon" "vpc_cni" {
    cluster_name  = aws_eks_cluster.this.name
    addon_name    = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "kube-proxy"
}

# resource "aws_eks_addon" "ebs_csi" {
#     cluster_name              = aws_eks_cluster.this.name
#     addon_name                = "aws-ebs-csi-driver"
#     service_account_role_arn  = aws_iam_role.ebs_csi.arn 
# }

# resource "aws_eks_addon" "cloudwatch_observability" {
#     cluster_name  = aws_eks_cluster.this.name
#     addon_name    = "amazon-cloudwatch_observability"
# }