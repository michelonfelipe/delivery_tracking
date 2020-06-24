resource "aws_sns_topic_subscription" "lambda_notification_request_update" {
  topic_arn              = aws_sns_topic.notification_request_update.arn
  protocol               = "lambda"
  endpoint_auto_confirms = true
  endpoint               = aws_lambda_function.notification_request_update.arn
}
