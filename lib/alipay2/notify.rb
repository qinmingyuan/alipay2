module Alipay
  module Notify
    extend self

    def verify?(params, options = {})
      params = Utils.stringify_keys(params)
      pid = options[:pid] || Alipay.pid
      Sign.verify?(params, options) && verify_notify_id?(pid, params['notify_id'])
    end

    def verify_notify_id?(pid, notify_id)
      uri = URI("https://mapi.alipay.com/gateway.do")
      uri.query = URI.encode_www_form(
        'service'   => 'notify_verify',
        'partner'   => pid,
        'notify_id' => notify_id
      )
      Net::HTTP.get(uri) == 'true'
    end

  end
end
