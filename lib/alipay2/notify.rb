module Alipay
  module Notify
    extend self

    def verify?(params)
      Sign.verify?(params)
    end

  end
end
