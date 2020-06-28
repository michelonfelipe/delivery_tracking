# SNS
output "notification_request_update_topic_arn" {
  value = aws_sns_topic.notification_request_update.arn
}
