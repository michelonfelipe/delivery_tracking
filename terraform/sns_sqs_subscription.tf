resource "aws_sns_topic_subscription" "sns_topic_subscription_example" {
  endpoint             = aws_sqs_queue.example_queue.arn
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.example_topic.arn
}
