require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../mruby/bin/pfds")

assert('short self') do
  output, status = Open3.capture2(BIN_PATH, "short", "self")

  assert_true status.success?, "Process did not exit cleanly"
  assert_equal output.split("\n").size, 1
  assert_include output, "#{ENV['LOGNAME']} /proc/"
end

assert('self') do
  output, status = Open3.capture2(BIN_PATH, "self")

  assert_true status.success?, "Process did not exit cleanly"
  assert_equal output.split("\n").size, 1
  assert_include output, "#{ENV['LOGNAME']} /proc/"
end
