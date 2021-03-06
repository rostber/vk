# coding: utf-8
require 'vk'

module Vk
  # Class for requesting vk.com api data
  # @author Alexander Semyonov
  class Error < StandardError
    def initialize(msg, details = {})
      if msg.is_a?(Hash)
        details, msg = msg, msg['error']['error_msg']
      end
      super(msg)
      @details = details
    end

    attr_reader :details
  end
end
