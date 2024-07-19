require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }

  describe "POST /posts" do
    it "creates a new post" do
      post_params = {
        post: {
          content: "Hello, world!",
          user_id: user.id
        }
      }

      post "/posts", params: post_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['post']['content']).to eq("Hello, world!")
    end
  end

  describe "GET /posts" do
    let!(:post1) { create(:post, user: user) }
    let!(:post2) { create(:post, user: user) }

    it "returns a list of posts" do
      get "/posts"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "PUT /posts/:id" do
    let!(:post) { create(:post, user: user) }

    it "updates a post" do
      put_params = {
        post: {
          content: "Updated content"
        }
      }

      put "/posts/#{post.id}", params: put_params

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['post']['content']).to eq("Updated content")
    end
  end

  describe "DELETE /posts/:id" do
    let!(:post) { create(:post, user: user) }

    it "deletes a post" do
      delete "/posts/#{post.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']).to eq("Post deleted successfully")
    end
  end
end
