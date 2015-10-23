def __main__(argv)
  exit if argv.size == 1
  if argv[1] == "version"
    puts "v#{Pfds::VERSION}"
  else
    pids = argv[1..-1]
    Pfds.run pids
  end
end
