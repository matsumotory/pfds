module Pfds
  module Config

    MULTI_PROCESS = (ENV["MRUBY_MULTI"] || 4).to_i

    IGNORE_FILES = %w(

    /dev/null
    /var/log/httpd/access_log
    /var/log/httpd/ssl_access_log
    /var/log/httpd/error_log
    /var/log/httpd/ssl_error_log

    )

    IGNORE_PATTERN = %w(

    ^pipe:
    ^anon_inode:
    ^socket:
    ^/dev/pts/

    )
  end
end
