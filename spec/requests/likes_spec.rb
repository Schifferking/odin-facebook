require 'rails_helper'
require 'support/shared_contexts/login_user'

RSpec.describe Like, type: :request do
  include_context :login_user

  let(:valid_attributes) do
    create(:post)
    { user_id: 1, post_id: 1 }
  end

  let(:invalid_attributes) do
    { user_id: nil, post_id: nil }
  end

  describe 'POST /likes' do
    context 'with valid parameters' do
      it 'redirects to post_path with post_id' do
        post likes_url, params: { like: valid_attributes }
        expect(response).to redirect_to(post_url(:post_id))
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity http status' do
        post likes_url, params: { like: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end