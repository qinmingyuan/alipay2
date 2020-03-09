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
      when 'RSA'
        key = options[:key] || Alipay2.config.rsa_pem
        RSA.sign(key, string)
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
      if Alipay2.config.sandbox
        rsa = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkFw7Q6tZRL3tqTTFiVh5y5EXXJ932aE3DYUVRqTRMi/iBLi27Asm3TDVvwQaupBQH+zy7S17n69ItZw3P0fP95EQ7UHt6pRlvQzSa9UA1UXYLsKppzz8fX3JfVooyV75rA44KQnRBkpqZYzYkGBrsDLfEKBr3m62zURlJI+Z3vYQcE5wONzwHUr8SyA5+mNwzwaNDI7AjbebP6WgleR7F1H/lARAQSonHMIBxF5je5MyxQSSPOsJdY6BQgkzqELXvjtj958ls/lfTcX6kyUWjOltj78octkkhXAE7gyeHPd8fqFVfTBGr1hofkSosN1GsGktnMVrRJwsg4GKnR7wHwIDAQAB'
      else
        rsa = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB'
      end
      @return_rsa = "-----BEGIN PUBLIC KEY-----\n" + rsa + "\n-----END PUBLIC KEY-----"
    end

    # https://docs.open.alipay.com/291/106130
    # openssl genrsa -out app_private_key.pem
    # openssl rsa -in app_private_key.pem -pubout -out app_public_key.pem
    def rsa2_key
      File.read(Alipay2.root.join Alipay2.config.rsa2_pem)
    end

  end
end
