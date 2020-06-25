resource "aws_cloudwatch_log_group" "lambda_notification_request_update" {
  name              = "/aws/lambda/${aws_lambda_function.notification_request_update.function_name}"
  retention_in_days = 14
}
