module Alipay2
  module Utils
    extend self

    def timestamp
      Time.now.strftime('%Y-%m-%d %H:%M:%S')
    end

    # 退款批次号，支付宝通过此批次号来防止重复退款操作，所以此号生成后最好直接保存至数据库，不要在显示页面的时候生成
    # 共 24 位(8 位当前日期 + 9 位纳秒 + 1 位随机数)
    def generate_batch_no
      t = Time.now
      batch_no = t.strftime('%Y%m%d%H%M%S') + t.nsec.to_s
      batch_no.ljust(24, rand(10).to_s)
    end

    def params_to_string(params)
      params.sort.map { |item| item.join('=') }.join('&')
    end

    def params_to_simple_string(params)
      params.map { |key, value| "#{key}=#{value}" }.join('&')
    end

    def check_params(params, required, optional = nil)
      lost = (required - params.keys)

      raise("Alipay2 Warn: missing required params: #{lost.join(', ')}")  if lost.size >= 1


      #raise("Alipay2 Warn: must specify either #{optional.join(' or ')}") if optional.all? { |name| params[name].nil? }
    end

  end
end
