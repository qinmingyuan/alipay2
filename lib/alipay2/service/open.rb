# frozen_string_literal: true

module Alipay
  module Service
    class Open

      TRADE_WAP_PAY_REQUIRED = [
        :out_trade_no,
        :subject,
        :total_fee,
        :body
      ]
      def trade_wap_pay(params, options = {})
        Alipay::Utils.check_params(params, TRADE_WAP_PAY_REQUIRED)

        params.merge!(method: 'alipay.trade.wap.pay')
        request_uri(params, options)
      end

      TRADE_PAGE_PAY_REQUIRED = [
        :out_trade_no,
        :product_code,
        :total_amount,
        :subject
      ]
      def trade_page_pay(params, options = {})
        params = { product_code: 'FAST_INSTANT_TRADE_PAY' }.merge(params)
        Alipay::Utils.check_params(params, TRADE_PAGE_PAY_REQUIRED)

        options.merge!(method: 'alipay.trade.page.pay')
        request_uri(params, options)
      end

    end
  end
end
