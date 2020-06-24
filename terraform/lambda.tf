resource "aws_lambda_function" "notification_request_update" {
  filename         = var.lambda_notification_request_update_filename
  function_name    = var.lambda_notification_request_update_name
  role             = aws_iam_role.lambda_role.arn
  handler          = var.lambda_notification_request_update_handler
  runtime          = var.lambda_notification_request_update_runtime
  timeout          = var.lambda_notification_request_update_timeout
  source_code_hash = filebase64sha256(var.lambda_notification_request_update_filename)
}

resource "aws_lambda_permission" "notification_request_update_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notification_request_update.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.notification_request_update.arn
}
