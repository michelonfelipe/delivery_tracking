# SNS
output "example_topic_arn" {
  value = aws_sns_topic.example_topic.arn
}

# SQS
output "example_queue_arn" {
  value = aws_sqs_queue.example_queue.arn
}
