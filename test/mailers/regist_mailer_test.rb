require 'test_helper'

class RegistMailerTest < ActionMailer::TestCase
  test "sendmaild_confirm" do
    mail = RegistMailer.sendmaild_confirm
    assert_equal "Sendmaild confirm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
