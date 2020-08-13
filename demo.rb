module Annotate
  @@deprecated = false

  def deprecate
    @@deprecated = true
  end

  def method_added(name)
    super

    return unless @@deprecated
    @@deprecated = false

    original_method = instance_method(name)
    define_method(name) do |*args, &block|
      super_method = original_method.bind(self)
      puts "WARNING: This method #{name} is deprecated"
      super_method.call(*args, &block)
    end
  end
end

class Demo
  extend Annotate

  deprecate
  def old_method
    'old'
  end

  def new_method
    'new'
  end
end

d = Demo.new
puts d.old_method  # this should print a deprecation warning
puts d.new_method
