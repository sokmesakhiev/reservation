class BaseParser
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def self.parse(*args)
    new(*args).parse
  end
end
