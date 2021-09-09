module Payloads
  class BasePayload
    attr_reader :attributes

    def initialize(attributes)
      @attrbutes = attributes
    end
  end
end
