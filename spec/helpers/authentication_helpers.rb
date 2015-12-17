module AuthenticationHelpers
  def controller_sign_in_as(user) do
    request.session[:user_id] = user.id
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelpers
end
