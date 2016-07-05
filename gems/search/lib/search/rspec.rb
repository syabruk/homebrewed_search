path = File.join(__dir__, '/../../spec/support/matchers/**/*.rb')
Dir[path].sort.each do |f|
  require f
end
