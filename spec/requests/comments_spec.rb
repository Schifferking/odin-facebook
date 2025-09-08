require 'rails_helper'
require 'support/shared_contexts/login_user'

RSpec.describe Comment, type: :request do
  include_context :login_user

  let(:valid_attributes) do
    user_post = create(:post)
    { content: 'comment', user_id: user.id, post_id: user_post.id }
  end

  let(:invalid_attributes) do
    { content: nil, user_id: nil, post_id: nil }
  end

  describe 'POST /comments' do
    context 'with valid parameters' do
      it 'redirects to post_url with post_id' do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(post_url(:post_id))
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_content http status' do
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
