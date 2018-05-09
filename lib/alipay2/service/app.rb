# frozen_string_literal: true

module Alipay2
  module Service
    module App
      API = {
        trade_app_pay: {
          method: 'alipay.trade.app.pay',
          required: [:subject, :out_trade_no, :total_amount, :product_code],
          default: { product_code: 'QUICK_MSECURITY_PAY' }
        }
      }

      API.each do |key, api|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{key}_params(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay2::Utils.check_params(params, #{api[:required]})
            
            options.merge!(method: '#{api[:method]}')
            sdk_execute(params, options)
          end
        RUBY_EVAL
      end

    end
  end
end
