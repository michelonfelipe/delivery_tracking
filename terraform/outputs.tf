# SNS
output "notification_request_creation_topic_arn" {
  value = aws_sns_topic.notification_request_creation.arn
}

output "notification_request_update_topic_arn" {
  value = aws_sns_topic.notification_request_update.arn
}

# SQS
output "notification_request_creation_queue_arn" {
  value = aws_sqs_queue.notification_request_creation.arn
}
