module Pfds
  class Top
    attr_reader :data

    def initialize
      @data = {}
      self
    end

    def create_top_data output
      output.split("\n").each do |line|
        line_ary = line.gsub(/^\s+/, "").split(/\s+/)
        if !line_ary[0].nil? and line_ary[0].to_i != 0 and line_ary.size == 12
          @data.merge!(line_ary[0] => line_ary[1..11])
        end
      end
    end

    def run
      create_top_data `top -b -n1`
      self
    end
  end
end
