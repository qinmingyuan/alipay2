require 'openssl'
require 'base64'

module Alipay2
  module Sign
    module RSA2
      extend self

      def sign(key, string)
        digest = OpenSSL::Digest::SHA256.new
        pkey = OpenSSL::PKey::RSA.new(key)
        signature = pkey.sign(digest, string)

        Base64.strict_encode64(signature)
      end

      def verify?(key, string, sign)
        rsa = OpenSSL::PKey::RSA.new(key)
        rsa.verify('sha256', Base64.strict_decode64(sign), string)
      end

    end
  end
end
