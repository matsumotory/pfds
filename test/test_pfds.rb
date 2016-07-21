class TestPfds < MTest::Unit::TestCase
  @@test_config = {
    "ignore_files" => [
      "/var/log/httpd/access_log"
    ],
    "ignore_patterns" => [
      "^socket:"
    ]
  }

  def test_main
    assert_nil __main__(["self"])
  end
  def test_file_ignore
    assert_true Pfds.file_ignore?("/var/log/httpd/access_log", @@test_config["ignore_files"])
  end
  def test_file_ignore_false
    assert_false Pfds.file_ignore?("/var/log/httpd/access_log.1", @@test_config["ignore_files"])
  end
  def test_pattern_ignore
    assert_true Pfds.pattern_ignore?("socket:00000", @@test_config["ignore_patterns"])
  end
  def test_pattern_ignore_false
    assert_false Pfds.pattern_ignore?("tcp:00000", @@test_config["ignore_patterns"])
  end
end

MTest::Unit.new.run
