RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller

  module ExtraDeviseTestHelpers
    def login user
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end
  end
  config.include ExtraDeviseTestHelpers
end
