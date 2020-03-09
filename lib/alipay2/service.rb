# frozen_string_literal: true

require 'alipay2/service/app'
require 'alipay2/service/page'
require 'alipay2/service/api'
require 'alipay2/service/auth'

module Alipay2
  module Service
    extend self
    extend App
    extend Page
    extend Api
    extend Auth

    def base_url
      return @base_url if defined? @base_url
      if Alipay2.config.sandbox
        @base_url = URI('https://openapi.alipaydev.com/gateway.do')
      else
        @base_url = URI('https://openapi.alipay.com/gateway.do')
      end
    end

    def execute(params, options = {})
      params = prepare_params(params, options)

      url = base_url
      Net::HTTP.post_form(url, params).body
    end

    def page_execute_url(params, options = {})
      params = prepare_page_params(params, options)

      url = base_url
      url.query = URI.encode_www_form(params)
      url.to_s
    end

    def sdk_execute(params, options = {})
      params = prepare_params(params, options)

      URI.encode_www_form(params)
    end

    def prepare_page_params(params, options = {})
      result = {
        return_url: params.fetch(:return_url, Alipay2.config.return_url),
        notify_url: params.fetch(:notify_url, Alipay2.config.notify_url)
      }
      result.compact!
      result.merge! common_params(options)
      result[:biz_content] = params.to_json if params.size >= 1
      result.merge! sign_params(result)
      result
    end

    def prepare_params(params, options = {})
      result = {}
      result.merge! common_params(options)
      result[:biz_content] = params.to_json if params.size >= 1
      result.merge! sign_params(result)
      result
    end

    def common_params(params)
      params[:app_id] ||= Alipay2.config.appid
      params.merge!(
        charset: 'utf-8',
        timestamp: Alipay2::Utils.timestamp,
        version: '1.0',
        format: 'JSON'  # optional
      )
    end

    def sign_params(params)
      params[:sign_type] ||= 'RSA2'
      params[:sign] = Alipay2::Sign.generate(params)
      params
    end
  end
end
