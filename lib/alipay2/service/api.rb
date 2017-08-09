# frozen_string_literal: true

module Alipay
  module Service
    module Api

      API = {
        trade_query: {
          method: 'alipay.trade.query',
          required: [:out_trade_no],
          default: {}
        }
      }

      API.each do |key, api|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{key}(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay::Utils.check_params(params, #{api[:required]})
            
            params.merge!(method: '#{api[:method]}')
            execute(params, options)
          end

          def #{key}_url(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay::Utils.check_params(params, #{api[:required]})
            
            params.merge!(method: '#{api[:method]}')
            page_execute_url(params, options)
          end
        RUBY_EVAL
      end

    end
  end
end
