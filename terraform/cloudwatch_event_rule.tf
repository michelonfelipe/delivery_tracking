resource "aws_cloudwatch_event_rule" "every_one_hour_on_business_hours_on_weekdays" {
    name = "every-one-hour-on-business-hours-on-weekdays"
    description = "Fires every one hour on business hours on weekdays"

    # this cron run in UTC, so BRT time will be 8-18
    schedule_expression = "cron(0 11-21 ? * MON-FRI *)"
}
