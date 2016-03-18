require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    mail = UserMailer.account_activation
    assert_equal "Account activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end

class UserMailerPreview < ActionMailer::Preview

    # Preview this email at
    # http://localhost:3000/rails/mailers/user_mailer/account_activation
    def account_activation
      UserMailer.account_activation
    end

    # Preview this email at
    # http://localhost:3000/rails/mailers/user_mailer/password_reset
    def password_reset
      UserMailer.password_reset
    end

end
