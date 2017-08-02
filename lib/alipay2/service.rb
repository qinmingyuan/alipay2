# frozen_string_literal: true

require 'alipay2/service/open'
require 'alipay2/service/auth'

module Alipay
  module Service
    extend Auth
    extend Open

    def account_page_query(params, options = {})
      params = {
        service: 'account.page.query',
        _input_charset: 'utf-8',
        partner: options[:pid] || Alipay.pid,
      }.merge(params)

      Net::HTTP.get(request_uri(params))
    end

    def request_uri(params, options = {})
      params = process_params(params, options)

      uri = URI(Alipay.config.app.gateway_url)
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    def process_params(params, options ={})
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
