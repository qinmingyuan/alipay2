require 'test_helper'

class Alipay2Test < Minitest::Test

  def test_debug_mode_default
    assert Alipay2.debug_mode?
  end

  def test_sign_type_default
    assert_equal 'MD5', Alipay2.sign_type
  end

end
