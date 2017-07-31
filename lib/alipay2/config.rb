require 'active_support/configurable'

module Alipay
  include ActiveSupport::Configurable

  configure do |config|
    config.partner = ActiveSupport::OrderedOptions.new
    config.app = ActiveSupport::OrderedOptions.new

    config.debug_mode = true

    config.partner.pid = nil
    config.partner.key = nil
    config.partner.sign_type = 'MD5'
    config.partner.return_rsa = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB'
    config.partner.gateway_url = 'https://mapi.alipay.com/gateway.do'

    config.app.appid = nil
    config.app.target_id = nil
    config.app.gateway_url = 'https://openapi.alipay.com/gateway.do'
    config.app.return_url = nil
    config.app.rsa2_pem = 'config/alipay_rsa2.pem'
    config.app.rsa_pem = 'config/alipay_rsa.pem'

  end
end
