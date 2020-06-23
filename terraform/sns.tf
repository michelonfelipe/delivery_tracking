resource "aws_sns_topic" "notification_request_creation" {
  name = var.sns_topic_name_notification_request_creation
}

resource "aws_sns_topic" "notification_request_update" {
  name = var.sns_topic_name_notification_request_update
}
