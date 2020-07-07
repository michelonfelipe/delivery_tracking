resource "aws_cloudwatch_log_group" "lambda_notification_request_update" {
  name              = "/aws/lambda/${aws_lambda_function.notification_request_update.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
}

resource "aws_cloudwatch_log_group" "lambda_remind_update_notification_requests" {
  name              = "/aws/lambda/${aws_lambda_function.remind_update_notification_requests.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
}

resource "aws_cloudwatch_log_group" "lambda_remind_close_inactive_notification_requests" {
  name              = "/aws/lambda/${aws_lambda_function.remind_close_inactive_notification_requests.function_name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
}
