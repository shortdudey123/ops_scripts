require 'rubocop/rake_task'

desc 'Run all linters on the codebase'
task :linters do
  Rake::Task['rubocop'].invoke
end

desc 'rubocop compliancy checks'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w{ */*.rb }
  t.fail_on_error = true
end

task default: [:rubocop]
