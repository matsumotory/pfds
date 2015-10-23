module Pfds

  @@gmutex = nil
  @@top = nil

  class << self

    def file_ignore? path
      (path == "" or Config::IGNORE_FILES.include? path) ? true : false
    end

    def pattern_ignore? path
      is_next = false
      Config::IGNORE_PATTERN.each do |pattern|
        if Regexp.new(pattern).match(path)
          is_next = true
          break
        end
      end
      is_next
    end

    def search_from_pids pids
      files = []
      pids.each do |pid|
        fd_dir = "/proc/#{pid}/fd/"
        begin
          Dir.foreach(fd_dir) do |fd|
            begin
              realpath = pfds_readlink("#{fd_dir}/#{fd}").to_s
            rescue
              next
            end
            next if self.file_ignore? realpath
            next if self.pattern_ignore? realpath
            username = nil
            begin
              username = pfds_get_username(File::Stat.new(realpath).uid)
            rescue
              username = pfds_get_username(File::Stat.new("#{fd_dir}/#{fd}").uid)
            end
            pid = Process.pid.to_s if pid == "self"
            if @@top.nil?
              files << sprintf("% 6d %s %s", pid.to_i, username, realpath)
            else
              files << sprintf("% 6d %5.1f %4.1f %s %s", pid.to_i, @@top[pid][7].to_f, @@top[pid][8].to_f, username, realpath)
            end
          end
        rescue
          next
        end
      end
      files
    end

    def output files
      @@gmutex.lock unless @@gmutex.nil?
      files.uniq.each { |f| puts f }
      @@gmutex.unlock unless @@gmutex.nil?
    end

    def run_task pids
      self.output search_from_pids(pids)
    end

    def multi_run_task pids
      wait_pids = []
      multi_pids = pids.group_by { |pid| pid.to_i % Config::MULTI_PROCESS }
      multi_pids.each_value { |pids| wait_pids << Process.fork { self.run_task pids} }
      wait_pids.each { |pid| Process.waitpid pid }
    end

    def short? pids
      pids[0] == "short"
    end

    def run argv
      @@top = Top.new.run.data unless short? argv
      pids = (@@top.nil?) ? argv[1..-1] : argv

      if pids.size > Config::MULTI_PROCESS
        @@gmutex = Mutex.new :global => true
        self.multi_run_task pids
      else
        self.run_task pids
      end
    end
  end
end
