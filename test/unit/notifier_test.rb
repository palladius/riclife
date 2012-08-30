require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "bella_ric_prova_gmail" do
    @expected.subject = 'Notifier#bella_ric_prova_gmail'
    @expected.body    = read_fixture('bella_ric_prova_gmail')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_bella_ric_prova_gmail(@expected.date).encoded
  end

end
