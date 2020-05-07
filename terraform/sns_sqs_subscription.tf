resource "aws_sns_topic_subscription" "sqs_notification_request_creation" {
  endpoint               = aws_sqs_queue.notification_request_creation.arn
  endpoint_auto_confirms = true
  protocol               = "sqs"
  raw_message_delivery   = true
  topic_arn              = aws_sns_topic.notification_request_creation.arn
}
