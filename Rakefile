require 'rake/clean'

$:.unshift 'lib'

task :run do
  mkdir_p 'mnt'
  sh('ruby', '-Ilib', 'bin/clipfs', 'mnt')
end
