ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)

require 'rails/test_help'
require 'minitest'
require 'minitest/spec'

require 'factory_bot_rails'

class ActiveSupport::TestCase
  include ApplicationHelper
  include FactoryBot::Syntax::Methods

  # Returns true if a test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end
end
