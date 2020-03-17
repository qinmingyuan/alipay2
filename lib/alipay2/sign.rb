require 'alipay2/sign/rsa'
require 'alipay2/sign/rsa2'

module Alipay2
  module Sign
    extend self

    def generate(params, options = {})
      sign_type = params[:sign_type]
      params = params.dup
      [:sign].each { |key| params.delete(key) }

      string = Utils.params_to_string(params)

      case sign_type
      when 'RSA2'
        key = options[:key] || rsa2_key
        RSA2.sign(key, string)
      else
        raise ArgumentError, "invalid sign_type #{sign_type}, allow value: MD5, RSA, RSA2"
      end
    end

    def verify?(params)
      sign_type = params.delete('sign_type')
      sign = params.delete('sign')
      string = Utils.params_to_string(params)

      case sign_type
      when 'RSA'
        RSA.verify?(return_rsa, string, sign)
      when 'RSA2'
        RSA2.verify?(return_rsa, string, sign)
      else
        false
      end
    end

    def return_rsa
      return @return_rsa if defined? @return_rsa
      @return_rsa = "-----BEGIN PUBLIC KEY-----\n" + Alipay2.config.return_rsa + "\n-----END PUBLIC KEY-----"
    end

    # https://docs.open.alipay.com/291/106130
    # openssl genrsa -out app_private_key.pem
    # openssl rsa -in app_private_key.pem -pubout -out app_public_key.pem
    def rsa2_key
      File.read(Alipay2.root.join Alipay2.config.rsa2_path)
    end

  end
end
