require 'net/http'
require 'cgi'

require 'alipay2/version'
require 'alipay2/config'
require 'alipay2/utils'
require 'alipay2/sign'
require 'alipay2/service'

module Alipay
  attr_accessor :root
  extend self

  def debug_mode?
    Alipay.config.debug_mode
  end


  if defined?(Rails)
    class Railtie < Rails::Railtie
      initializer 'alipay.setup_paths' do |app|
        Alipay.root = Rails.root
      end
    end
  end

end
