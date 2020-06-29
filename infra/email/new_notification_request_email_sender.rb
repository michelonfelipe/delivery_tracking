# frozen_string_literal: true

require 'sendgrid-ruby'

# TODO: Use i18n on email content
class NewNotificationRequestEmailSender
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
    'Recebemos a sua solicitação'
  end

  def content
    SendGrid::Content.new(
      type: 'text/plain',
      value: "A notificação para o código de rastreio \"#{@tracking_code}\" foi criada com sucesso!"
    )
  end
end
