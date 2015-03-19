class Message < ActionMailer::Base
  # デフォルトでの送信元のアドレス
  default from: "hiroki.shigemura.aiesec@gmail.com"

  def hello(email)
    mail to: email,  subject: 'Mail from Message'
  end
end

