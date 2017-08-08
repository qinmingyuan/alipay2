# frozen_string_literal: true

require 'alipay2/service/open'
require 'alipay2/service/auth'

module Alipay
  module Service
    extend self
    extend Auth
    extend Open

    def execute(params, options = {})
      params = prepare_params(params)

      Net::HTTP.post_form(URI(@url), params).body
    end

    def page_execute_url(params, options = {})
      params = prepare_params(params, options)

      uri = URI(Alipay.config.app.gateway_url)
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    def sdk_execute(params, options = {})
      params = prepare_params(params)

      URI.encode_www_form(params)
    end

    def prepare_params(params, options ={})
      result = {}
      result.merge! common_params(options)
      result.merge! biz_content: params if params.size >= 1
      result.merge! sign_params(result)
      result
    end

    def common_params(params)
      params[:app_id] ||= Alipay.config.app.appid
      params[:return_url] ||= Alipay.config.app.return_url if Alipay.config.app.return_url
      params[:notify_url] ||= Alipay.config.app.notify_url if Alipay.config.app.notify_url
      params.merge!(
        charset: 'utf-8',
        timestamp: Alipay::Utils.timestamp,
        version: '1.0',
        format: 'JSON'  # optional
      )
    end

    def sign_params(params)
      params[:sign_type] ||= 'RSA2'
      params[:sign] = Alipay::Sign.generate(params)
      params
    end

  end
end
