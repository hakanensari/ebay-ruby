require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push('lib', 'test')
  t.test_files = FileList['test/**/test_*.rb']
end

task default: [:test]
