resource "aws_cloudwatch_event_target" "update_notification_requests_every_hour" {
    rule = aws_cloudwatch_event_rule.every_one_hour.name
    arn = aws_lambda_function.remind_update_notification_requests.arn
}
