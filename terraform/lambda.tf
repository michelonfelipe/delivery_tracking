resource "aws_lambda_function" "notification_request_update" {
  filename         = var.lambda_notification_request_update_filename
  function_name    = "update-notification-request"
  role             = aws_iam_role.lambda_role.arn
  handler          = var.lambda_notification_request_update_handler
  runtime          = var.lambda_notification_request_update_runtime
  timeout          = var.lambda_notification_request_update_timeout
  source_code_hash = filebase64sha256(var.lambda_notification_request_update_filename)

  environment {
    variables = {
      BACKEND_URL = var.lambda_backend_url
      SHARED_SECRET = var.lambda_shared_secret
    }
  }
}

resource "aws_lambda_function" "remind_update_notification_requests" {
  filename         = var.lambda_remind_update_notification_requests_filename
  function_name    = "remind-update-notification-requests"
  role             = aws_iam_role.lambda_role.arn
  handler          = var.lambda_remind_update_notification_requests_handler
  runtime          = var.lambda_remind_update_notification_requests_runtime
  timeout          = var.lambda_remind_update_notification_requests_timeout
  source_code_hash = filebase64sha256(var.lambda_remind_update_notification_requests_filename)

  environment {
    variables = {
      BACKEND_URL = var.lambda_backend_url
      SHARED_SECRET = var.lambda_shared_secret
    }
  }
}
resource "aws_lambda_function" "remind_close_inactive_notification_requests" {
  filename         = var.lambda_remind_close_inactive_notification_requests_filename
  function_name    = "remind-close-inactive-notification-requests"
  role             = aws_iam_role.lambda_role.arn
  handler          = var.lambda_remind_close_inactive_notification_requests_handler
  runtime          = var.lambda_remind_close_inactive_notification_requests_runtime
  timeout          = var.lambda_remind_close_inactive_notification_requests_timeout
  source_code_hash = filebase64sha256(var.lambda_remind_close_inactive_notification_requests_filename)

  environment {
    variables = {
      BACKEND_URL = var.lambda_backend_url
      SHARED_SECRET = var.lambda_shared_secret
    }
  }
}
