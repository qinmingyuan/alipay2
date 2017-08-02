module Alipay
  module Sign
    module DSA
      extend self

      def self.sign(key, string)
        raise NotImplementedError, 'DSA sign is not implemented'
      end

      def self.verify?(string, sign)
        raise NotImplementedError, 'DSA verify is not implemented'
      end

    end
  end
end
