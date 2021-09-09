RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

module FactoryBot
  module Strategy
    class Stub
      private

      def next_id
        SecureRandom.uuid
      end
    end
  end
end
