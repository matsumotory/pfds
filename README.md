# pfds  [![Build Status](https://travis-ci.org/matsumoto-r/pfds.svg?branch=master)](https://travis-ci.org/matsumoto-r/pfds)

pfds - report a snapshot of the current processes fd

pfds is one-binary and supports multi process. It's simple and powerful. 

## usage

- short version

```sh
$ sudo pfds short `pgrep nginx` `pgrep httpd` | head
   13963 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-includes/js/jquery/jquery-migrate.min.js
   13963 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-includes/js/jquery/jquery.js
   13963 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-includes/js/wp-emoji-release.min.js
   13963 matsumoto_r /usr/local/apache-2.4.16/htdocs/moblog/robots.txt
   13964 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/favicon.ico
   13964 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/akismet/_inc/form.js
   13964 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/codecolorer/codecolorer.css
   13964 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/oembed-instagram/oembed-instagram.js
   13964 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/shadowbox-js/css/extras.css
   19940 matsumoto_r /usr/local/apache-2.4.16/htdocs/moblog/wp-content/uploads/2012/12/20121229-180225.jpg
   19940 matsumoto_r /usr/local/apache-2.4.16/htdocs/moblog/wp-content/uploads/2012/12/20121224-202408.jpg
```

- output with cpu and memory usage

```sh
$ sudo pfds `pgrep nginx` `pgrep httpd` | sort -nk2 | tail
   13963  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-includes/js/jquery/jquery-migrate.min.js
   13963  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-includes/js/jquery/jquery.js
   13963  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-includes/js/wp-emoji-release.min.js
   13963  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/moblog/robots.txt
   13964  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/favicon.ico
   13964  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/akismet/_inc/form.js
   13964  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/codecolorer/codecolorer.css
   13964  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/oembed-instagram/oembed-instagram.js
   13964  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/shadowbox-js/css/extras.css
   19940  0.0  0.3 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/wp-content/plugins/wp-social-bookmarking-light/images/hatena.gif
   29391 24.5  2.4 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/index.php
   29395 29.7  3.0 matsumoto_r /usr/local/apache-2.4.16/htdocs/blog/index.php
```

- Adjust multi process (default 4 process)

```sh
sudo MRUBY_MULTI=24 pfds `pgrep httpd` 
```

```sh
sudo MRUBY_MULTI=1 pfds `pgrep httpd` 
```

## build

- custom `mrblib/pfds/config.rb`

```ruby
module Pfds
  module Config

    MULTI_PROCESS = (ENV["MRUBY_MULTI"] || 4).to_i

    CONFIG_PATH = (ENV.key?("PFDS_CONFIG") ? ENV["PFDS_CONFIG"] : "/etc/pfds.json")

  end
end
```

- build into `mruby/bin/pfds`

```sh
rake
```

## install to `/usr/local/bin`

```sh
rake install
```

* Also put configration file to `/etc/pfds.json`.

## configure

```sh
{
  "ignore_files": [
    "/dev/null",
    "/var/log/httpd/access_log",
    "/var/log/httpd/error_log",
    "/var/log/httpd/ssl_access_log",
    "/var/log/httpd/ssl_error_log"
  ],
  "ignore_patterns": [
    "^pipe:",
    "^anon_inode:",
    "^socket:",
    "^/dev/pts/"
  ]
}
```

* config file path will be set by `PFDS_CONFIG` of `ENV`.

# License
under the MIT License:

* http://www.opensource.org/licenses/mit-license.php
