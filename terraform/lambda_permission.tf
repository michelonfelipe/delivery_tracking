resource "aws_lambda_permission" "notification_request_update_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notification_request_update.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.notification_request_update.arn
}

resource "aws_lambda_permission" "remind_update_notification_requests_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.remind_update_notification_requests.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_one_hour_on_business_hours_on_weekdays.arn
}

resource "aws_lambda_permission" "remind_close_inactive_notification_requests_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.remind_close_inactive_notification_requests.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_one_hour_on_business_hours_on_weekdays.arn
}
