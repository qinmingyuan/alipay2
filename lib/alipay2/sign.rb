require 'alipay2/sign/rsa'
require 'alipay2/sign/rsa2'
require 'alipay2/sign/dsa'

module Alipay
  module Sign
    extend self

    def generate(params, options = {})
      sign_type = params[:sign_type]
      params = params.dup
      [:sign].each { |key| params.delete(key) }

      string = Utils.params_to_string(params)

      case sign_type
      when 'RSA'
        key = options[:key] || Alipay.config.rsa_pem
        RSA.sign(key, string)
      when 'DSA'
        key = options[:key] || Alipay.config.dsa_pem
        DSA.sign(key, string)
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
      when 'DSA'
        DSA.verify?(string, sign)
      else
        false
      end
    end

    def return_rsa
      @return_rsa ||= "-----BEGIN PUBLIC KEY-----\n" + Alipay.config.return_rsa + "\n-----END PUBLIC KEY-----"
    end

    def rsa2_key
      File.read(Alipay.root.join Alipay.config.rsa2_pem)
    end

  end
end
