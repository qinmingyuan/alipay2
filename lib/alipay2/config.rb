require 'active_support/configurable'

module Alipay
  include ActiveSupport::Configurable

  configure do |config|
    config.debug_mode = true
    config.pid = nil
    config.appid = nil
    config.target_id = nil
    config.gateway_url = 'https://openapi.alipay.com/gateway.do'
    config.return_url = nil
    config.notify_url = nil
    config.return_rsa = 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB'
    config.rsa2_pem = 'config/alipay_rsa2.pem'
    config.rsa_pem = 'config/alipay_rsa.pem'
  end
end
