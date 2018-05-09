require 'test_helper'

class Alipay2::Sign::MD5Test < Minitest::Test
  def setup
    @string = "partner=123&service=test"
    @sign = 'bbd13b52823b576291595f472ebcfbc2'
  end

  def test_sign
    assert_equal @sign, Alipay2::Sign::MD5.sign(Alipay2.key, @string)
  end

  def test_verify
    assert Alipay2::Sign::MD5.verify?(Alipay2.key, @string, @sign)
  end

  def test_verify_fail_when_sign_not_true
    assert !Alipay2::Sign::MD5.verify?(Alipay2.key, "danger#{@string}", @sign)
  end
end
