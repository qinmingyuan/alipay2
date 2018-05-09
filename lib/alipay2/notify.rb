module Alipay2
  module Notify
    extend self

    def verify?(params)
      Sign.verify?(params)
    end

  end
end
