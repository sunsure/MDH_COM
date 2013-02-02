require "spec_helper"

describe UserMailer do
  describe "concerning User confirmation Mailers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.confirmation(user) }

    it "has the right subject" do
      mail.subject.should eq("MDH.com Account Confirmation")
    end

    it "should send TO the right person" do
      mail.to.should include(user.email)
    end

    it "should be FROM the right address" do
      mail.from.should include("no-reply@markholmberg.com")
    end

    it "it has the right user name" do
      mail.body.encoded.should match(user.name)
    end

    it "should have an email to reply to in the body" do
      mail.body.encoded.should match("admin@example.com")
    end

    it "has a link to the confirmation url" do
      mail.body.encoded.should match(edit_confirm_url(user.confirm_token))
    end
  end

  describe "concerning User password reset Mailers" do
    let(:user) { FactoryGirl.create(:user, password_reset_sent_at: Time.zone.now, password_reset_token: '12345') }
    let(:mail) { UserMailer.reset_password(user) }

    it "has the right subject" do
      mail.subject.should eq("MDH.com Password Reset Request")
    end

    it "should send TO the right person" do
      mail.to.should include(user.email)
    end

    it "should be FROM the right address" do
      mail.from.should include("no-reply@markholmberg.com")
    end

    it "it has the right user name" do
      mail.body.encoded.should match(user.name)
    end

    it "should have an email to reply to in the body" do
      mail.body.encoded.should match("admin@example.com")
    end

    it "has a link to the confirmation url" do
      mail.body.encoded.should match(edit_password_reset_url(user.password_reset_token))
    end
  end
end
