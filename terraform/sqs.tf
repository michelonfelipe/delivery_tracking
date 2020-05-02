resource "aws_sqs_queue" "example_queue" {
  fifo_queue     = "false"
  name           = var.sqs_queue_name_example
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.example_queue_deadletter.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "example_queue_deadletter" {
  fifo_queue = "false"
  name       = var.sqs_queue_name_example_deadletter
}
