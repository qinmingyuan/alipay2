# frozen_string_literal: true

module Alipay
  module Service
    module Open

      API = {
        trade_wap_pay: {
          method: 'alipay.trade.wap.pay',
          required: [:out_trade_no, :subject, :total_fee, :body],
          default: {}
        },
        trade_page_pay: {
          method: 'alipay.trade.page.pay',
          default: { product_code: 'FAST_INSTANT_TRADE_PAY' },
          required: [:out_trade_no, :product_code, :total_amount, :subject]
        },
        trade_app_pay: {
          method: 'alipay.trade.app.pay',
          required: [:subject, :out_trade_no, :total_amount, :product_code],
          default: { product_code: 'QUICK_MSECURITY_PAY' }
        }
      }


      API.each do |key, api|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{key}(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay::Utils.check_params(params, #{api[:required]})
            
            params.merge!(method: '#{api[:method]}')
            page_execute_url(params, options)
          end

          def #{key}_params(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay::Utils.check_params(params, #{api[:required]})
            
            params.merge!(method: '#{api[:method]}')
            sdk_execute(params, options)
          end
        RUBY_EVAL
      end

    end
  end
end
