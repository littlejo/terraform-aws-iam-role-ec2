locals {
  assume_role_policy = var.assume_role_policy == null ? data.aws_iam_policy_document.this.json : var.assume_role_policy

  iam_policies = { for a in var.iam_policies : a.name => a }
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name                  = var.name
  name_prefix           = var.name_prefix
  description           = var.description
  assume_role_policy    = local.assume_role_policy
  path                  = var.path
  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.permissions_boundary

  managed_policy_arns = var.managed_policy_arns

  max_session_duration = var.max_session_duration

  dynamic "inline_policy" {
    for_each = var.inline_policies
    content {
      name   = inline_policy.value.name
      policy = inline_policy.value.policy
    }
  }

  tags = var.tags
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_profile ? 1 : 0
  role  = aws_iam_role.this.name

  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_policy" "this" {
  for_each    = local.iam_policies
  name        = each.value.name
  description = each.value.description
  path        = each.value.path
  policy      = each.value.policy
  tags        = each.value.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = local.iam_policies
  policy_arn = aws_iam_policy.this[each.key].arn
  role       = aws_iam_role.this.name
}
