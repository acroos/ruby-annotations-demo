require 'pry'

module Annotate
  @@tracking = false
  @@usage_stats = {}

  def track_usage
    @@tracking = true
  end

  def stats
    @@usage_stats
  end

  def method_added(name)
    super

    return unless @@tracking
    @@tracking = false
    @@usage_stats[name] ||= 0

    original_method = instance_method(name)
    define_method(name) do |*args, &block|
      super_method = original_method.bind(self)
      @@usage_stats[name] += 1
      super_method.call(*args, &block)
    end
  end
end

class Demo
  extend Annotate

  track_usage
  def one
    'one'
  end

  track_usage
  def two
    'two'
  end
end

d = Demo.new
puts "Run method 'one' 58 times"
58.times { d.one }
puts "Run method 'two' 221 times"
221.times { d.two }
puts "Print out stats"
puts Demo.stats
puts "Run method 'one' 3 more times"
3.times { d.one }
puts "Print out stats"
puts Demo.stats
