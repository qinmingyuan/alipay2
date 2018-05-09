require 'openssl'
require 'base64'

module Alipay2
  module Sign
    module RSA
      extend self

      def sign(key, string)
        rsa = OpenSSL::PKey::RSA.new(key)
        Base64.strict_encode64(rsa.sign('sha1', string))
      end

      def verify?(key, string, sign)
        rsa = OpenSSL::PKey::RSA.new(key)
        rsa.verify('sha1', Base64.strict_decode64(sign), string)
      end

    end
  end
end
