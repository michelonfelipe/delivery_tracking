resource "aws_cloudwatch_event_rule" "every_one_hour" {
    name = "every-one-hour"
    description = "Fires every one hour"
    schedule_expression = "rate(1 hour)"
}
