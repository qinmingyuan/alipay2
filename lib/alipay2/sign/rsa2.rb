require 'openssl'
require 'base64'

module Alipay
  module Sign
    module RSA2
      extend self

      def generate(params, options = {})
        params = Alipay::Utils.stringify_keys(params)
        ['sign', 'sign_type'].each { |key| params.delete(key) }

        Alipay::Utils.params_to_string(params)
      end

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
