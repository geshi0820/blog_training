class Message < ActionMailer::Base
  # デフォルトでの送信元のアドレス
  default from: "hiroki.shigemura.aiesec@gmail.com"

  def register(resource)
  	@email = resource.email
  	@user = resource.username
  	@password = resource.password
    mail to: @email,  subject: 'Mail from Message'
  end
end

