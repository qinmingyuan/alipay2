# frozen_string_literal: true

module Alipay2
  module Service
    module Api

      API = {
        trade_query: {
          method: 'alipay.trade.query',
          required: [:out_trade_no],
          default: {}
        },
        open_auth_token_app: {
          method: 'alipay.open.auth.token.app',
          required: [:grant_type],
          default: { grant_type: 'authorization_code' }
        },
        system_oauth_token: {
          method: 'alipay.system.oauth.token',
          required: [],
          default: {}
        },
        user_info_share: {
          method: 'alipay.user.info.share',
          required: [],
          default: {}
        },
        trade_refund: {
          method: 'alipay.trade.refund',
          default: {},
          required: [:out_trade_no, :refund_amount]
        }
      }

      API.each do |key, api|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{key}(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay2::Utils.check_params(params, #{api[:required]})
            
            options.merge!(method: '#{api[:method]}')
            execute(params, options)
          end

          def #{key}_url(params, options = {})
            params = #{api[:default]}.merge(params)
            Alipay2::Utils.check_params(params, #{api[:required]})
            
            options.merge!(method: '#{api[:method]}')
            page_execute_url(params, options)
          end
        RUBY_EVAL
      end

    end
  end
end
