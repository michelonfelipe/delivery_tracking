# SNS

variable "sns_topic_name_example" {
  description = "The name of the example sns topic"
  type        = string
}

# SQS
variable "sqs_queue_name_example" {
  description = "The name of the example sqs queue"
  type        = string
}

variable "sqs_queue_name_example_deadletter" {
  description = "The name of the example sqs queue deadletter"
  type        = string
}
