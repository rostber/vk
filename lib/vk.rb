require 'active_support/core_ext/object/try'
require 'vk/exceptions'

module Vk
  extend self

  autoload :DSL, 'vk/dsl'
  autoload :Client, 'vk/client'
  autoload :Result, 'vk/result'

  autoload :Base, 'vk/base'
  autoload :User, 'vk/user'
  autoload :City, 'vk/city'
  autoload :Country, 'vk/country'
  autoload :Post, 'vk/post'
  autoload :Stats, 'vk/stats'
  autoload :Group, 'vk/group'

  class << self
    attr_accessor :app_id, :app_secret, :logger
  end

  # Request to vk.com API
  # @return [Vk::Client] Vk API client
  def client(access_token = nil)
    @request ||= Client.new(access_token)
  end

  def verbose!(logger)
    require 'logger'
    self.logger = logger || Logger.new(STDOUT)
  end
end
