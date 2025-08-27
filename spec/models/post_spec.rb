require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '.friend_posts' do
    let(:social_user) { create(:user, id: 1) }
    let(:another_user) { create(:user, id: 2) }
    let(:first_post) { create(:post, id: 1, user: social_user) }
    let(:second_post) { create(:post, id: 2, user: social_user) }
    let(:create_posts) do
      first_post
      second_post
    end

    context 'when a user has posts' do
      it 'returns a list of posts' do
        create_posts
        expect(described_class.friend_posts(1)).to contain_exactly(Post, Post)
      end
    end

    context 'when a user has no posts' do
      it 'returns an empty array' do
        another_user
        expect(described_class.friend_posts(2)).to be_empty
      end
    end
  end
end
