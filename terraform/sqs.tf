resource "aws_sqs_queue" "notification_request_creation" {
  fifo_queue     = "false"
  name           = var.sqs_queue_name_notification_request_creation
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.notification_request_creation_deadletter.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue_policy" "notification_request_creation_queue_policy" {
  queue_url = aws_sqs_queue.notification_request_creation.id

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid = "First"
        Effect = "Allow"
        Principal = "*"
        Action = "sqs:SendMessage"
        Resource = aws_sqs_queue.notification_request_creation.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.notification_request_creation.arn
          }
        }
      }
    ]
  })
}

resource "aws_sqs_queue" "notification_request_creation_deadletter" {
  fifo_queue = "false"
  name       = var.sqs_queue_name_notification_request_creation_deadletter
}
