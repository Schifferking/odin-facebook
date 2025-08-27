require 'rails_helper'
require 'support/shared_contexts/login_user'

RSpec.describe Post, type: :request do
  include_context :login_user

  let(:valid_attributes) do
    { title: 'placeholder title', body: 'placeholder body', user_id: 1 }
  end

  let(:invalid_attributes) do
    { title: nil, body: nil, user_id: nil }
  end

  describe 'POST /posts' do
    context 'with valid attributes' do
      it 'redirects to @post' do
        post posts_url, params: { post: valid_attributes }
        expect(response).to redirect_to(post_path(Post.last.id))
      end
    end

    context 'with invalid attributes' do
      it 'renders new template' do
        post posts_url, params: { post: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it 'returns unprocessable_entity http status' do
        post posts_url, params: { post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end