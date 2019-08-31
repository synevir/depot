require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received--" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Подтверждение заказа в Pragmatic Store", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Ruby on Rails 4.2/, mail.body.encoded
  end

  test "shipped--" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Заказ из Pragmatic Store отправлен", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Ruby on Rails 4.2<\/td>/,
    mail.body.encoded
  end

end
