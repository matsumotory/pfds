class TestPfds < MTest::Unit::TestCase
  def test_main
    assert_nil __main__(["self"])
  end
  def test_file_ignore
    assert_true Pfds.file_ignore?("/var/log/httpd/access_log")
  end
  def test_file_ignore_false
    assert_false Pfds.file_ignore?("/var/log/httpd/access_log.1")
  end
  def test_pattern_ignore
    assert_true Pfds.pattern_ignore?("socket:00000")
  end
  def test_pattern_ignore_false
    assert_false Pfds.pattern_ignore?("tcp:00000")
  end
end

MTest::Unit.new.run
