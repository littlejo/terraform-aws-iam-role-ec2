output "instance_profile" {
  value = var.create_instance_profile ? aws_iam_instance_profile.this[0].id : ""
}
