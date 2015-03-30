RSpec.configure do |config|
  module JSONHelpers
    def json
      if response.body.empty?
        raise "Empty body; did you enable `render_views`?"
      else
        JSON.parse response.body
      end
    end
  end
  config.include JSONHelpers
end
