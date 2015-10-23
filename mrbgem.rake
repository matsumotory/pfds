MRuby::Gem::Specification.new('pfds') do |spec|
  spec.license = 'MIT'
  spec.author  = 'MATSUMOTO Ryosuke'
  spec.summary = 'pfds'
  spec.bins    = ['pfds']

  spec.add_dependency 'mruby-print', :core => 'mruby-print'
  spec.add_dependency 'mruby-array-ext', :core => 'mruby-array-ext'
  spec.add_dependency 'mruby-hash-ext', :core => 'mruby-hash-ext'
  spec.add_dependency 'mruby-mtest', :mgem => 'mruby-mtest'
  spec.add_dependency 'mruby-env', :mgem => 'mruby-env'
  spec.add_dependency 'mruby-dir', :mgem => 'mruby-dir'
  spec.add_dependency 'mruby-io', :mgem => 'mruby-io'
  spec.add_dependency 'mruby-process', :mgem => 'mruby-process'
  spec.add_dependency 'mruby-env', :mgem => 'mruby-env'
  spec.add_dependency 'mruby-mutex', :mgem => 'mruby-mutex'
  spec.add_dependency 'mruby-regexp-pcre', :mgem => 'mruby-regexp-pcre'
  spec.add_dependency 'mruby-file-stat', :mgem => 'mruby-file-stat'
end
