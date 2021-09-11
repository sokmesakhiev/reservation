module Payloads
  class BasePayload
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end
  end
end
