module Pfds
  module Config

    MULTI_PROCESS = (ENV["MRUBY_MULTI"] || 4).to_i

    CONFIG_PATH = '/etc/pfds.json'

  end
end
