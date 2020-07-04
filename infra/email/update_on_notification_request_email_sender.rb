# frozen_string_literal: true

require 'sendgrid-ruby'

class UpdateOnNotificationRequestEmailSender
  def initialize(to:, tracking_code:)
    @to = to
    @tracking_code = tracking_code
  end

  def send
    mail = SendGrid::Mail.new(from, subject, destiny, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts "[#{self.class}] sent email to #{@to}, \
          using #{@tracking_code} as tracking code, \
          and got the response: #{response}"
  end

  private

  def from
    SendGrid::Email.new(email: ENV['EMAIL_DEFAULT_SENDER'])
  end

  def destiny
    SendGrid::Email.new(email: @to)
  end

  def subject
    I18n.t('email.update_on_notification_request.subject')
  end

  def content
    SendGrid::Content.new(
      type: 'text/plain',
      value: I18n.t('email.update_on_notification_request.body', tracking_code: @tracking_code)
    )
  end
end
