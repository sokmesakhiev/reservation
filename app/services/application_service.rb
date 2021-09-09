class ApplicationService
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
    @context = OpenStruct.new(success: true)
  end

  def self.call(*args)
    begin
      new(*args).call
    rescue StandardError => e
      context = OpenStruct.new(success: false)
      context.errors = [e.message]

      context
    end
  end
end
