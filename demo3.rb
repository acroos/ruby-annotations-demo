module Docz
  @@docs = {}
  @@current_doc = nil

  def doc(text)
    @@current_doc = text
  end

  def print_docs
    class_name = self.name
    class_docs = @@docs[class_name]
    return 'No docs for this class' unless class_docs
    class_docs.each do |method_name, doc_text|
      puts "METHOD: #{class_name}##{method_name}"
      puts doc_text
      puts '-' * 30
    end
  end

  def method_added(name)
    super

    return unless @@current_doc

    class_name = self.name
    @@docs[class_name] ||= {}
    @@docs[class_name][name] = @@current_doc

    @@current_doc = nil
  end
end

class Demo
  extend Docz

  doc 'this does one ting'
  def one
    'one'
  end

  doc 'but this?  it does two!'
  def two
    'two'
  end
end

d = Demo.new

Demo.print_docs
