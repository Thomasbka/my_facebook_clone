require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "creates a new user" do
      user_params = {
        user: {
          username: "johndoe",
          email: "johndoe@example.com",
          first_name: "John",
          last_name: "Doe"
        }
      }

      post "/users", params: user_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['user']['username']).to eq("johndoe")
    end
  end
end
