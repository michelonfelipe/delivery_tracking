# SNS
variable "sns_topic_name_notification_request_creation" {
  description = "The name of the sns topic notification_request_creation"
  type        = string
}

variable "sns_topic_name_notification_request_update" {
  description = "The name of the sns topic notification_request_update"
  type        = string
}

# SQS
variable "sqs_queue_name_notification_request_creation" {
  description = "The name of the sqs queue notification_request_creation"
  type        = string
}

variable "sqs_queue_name_notification_request_creation_deadletter" {
  description = "The name of the sqs queue notification_request_creation_deadletter"
  type        = string
}
