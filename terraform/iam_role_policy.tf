resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "Stmt1592967687853",
        Action = "logs:*",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}
