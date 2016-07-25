module Pfds
  module Config

    MULTI_PROCESS = (ENV["MRUBY_MULTI"] || 4).to_i

    CONFIG_PATH = (ENV.key?("PFDS_CONFIG") ? ENV["PFDS_CONFIG"] : "/etc/pfds.json")

  end
end
