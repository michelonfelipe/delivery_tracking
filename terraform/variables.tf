# CloudWatch
variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days that a cloudwatch_log_group should keep logs"
  default = 14
  type    = number
}

# Lamba
variable "lambda_remind_update_notification_requests_handler" {
  description = "The handler of the lambda remind_update_notification_requests"
  type        = string
}

variable "lambda_remind_update_notification_requests_filename" {
  description = "The filename of the lambda remind_update_notification_requests"
  type        = string
}


variable "lambda_remind_update_notification_requests_runtime" {
  description = "The runtime language of the lambda remind_update_notification_requests"
  type        = string
}

variable "lambda_remind_update_notification_requests_timeout" {
  description = "The timeout, in seconds, of the lambda remind_update_notification_requests"
  type        = string
}


variable "lambda_remind_close_inactive_notification_requests_handler" {
  description = "The handler of the lambda remind_close_inactive_notification_requests"
  type        = string
}

variable "lambda_remind_close_inactive_notification_requests_filename" {
  description = "The filename of the lambda remind_close_inactive_notification_requests"
  type        = string
}


variable "lambda_remind_close_inactive_notification_requests_runtime" {
  description = "The runtime language of the lambda remind_close_inactive_notification_requests"
  type        = string
}

variable "lambda_remind_close_inactive_notification_requests_timeout" {
  description = "The timeout, in seconds, of the lambda remind_close_inactive_notification_requests"
  type        = string
}

variable "lambda_notification_request_update_handler" {
  description = "The handler of the lambda notification_request_update"
  type        = string
}

variable "lambda_notification_request_update_filename" {
  description = "The filename of the lambda notification_request_update"
  type        = string
}

variable "lambda_notification_request_update_runtime" {
  description = "The runtime language of the lambda notification_request_update"
  type        = string
}

variable "lambda_notification_request_update_timeout" {
  description = "The timeout, in seconds, of the lambda notification_request_update"
  type        = string
}

variable "lambda_backend_url" {
  description = "The backend url used in lambdas"
  type        = string
}

variable "lambda_shared_secret" {
  description = "The shared secret used in lambdas to communicate with the backend"
  type        = string
}

# SNS
variable "sns_topic_name_notification_request_update" {
  description = "The name of the sns topic notification_request_update"
  type        = string
}
