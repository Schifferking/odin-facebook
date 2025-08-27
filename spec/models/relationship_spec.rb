# To-do
# DRY tests setup
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '#validate_inverse_friend_request_uniqueness' do
    context 'when requested user has not accepted' do
      context 'a friend request from requester user' do
        let(:valid_relationship) { build(:relationship, :pending) }

        it 'is a valid relationship' do
          expect(valid_relationship).to be_valid
        end
      end
    end

    context 'when requested user is friend' do
      context 'with requester user' do
        let(:requester) { create(:user, name: 'John Doe', id: 1) }
        let(:requested) { create(:user, name: 'Jane Doe', id: 2) }
        let(:friends_relationship) { create(:relationship, requester: requester, requested: requested, relationship_type: 'friends') }
        let(:invalid_relationship) { build(:relationship, requester: requested, requested: requester, relationship_type: 'friends') }

        it 'is an invalid relationship' do
          friends_relationship()
          invalid_relationship.valid?
          expect(invalid_relationship.errors.full_messages).to include("Inverse combination already exists")
        end
      end
    end
  end

  describe '.entry_found?' do
  let(:first_user) { create(:user, id: 1) }
  let(:second_user) { create(:user, id: 2) }
  let(:relationship) { create(:relationship, requester: first_user, requested: second_user, relationship_type: 'pending') }
  
    context 'when there is a relationship' do
      context 'with user ids 1 and 2' do
        it 'it returns true' do
          relationship()
          expect(described_class.entry_found?(1, 2)).to eql(true)
        end
      end
    end

    context 'when there is not a relationship' do
      context 'with user ids 3 and 4' do
        it 'it returns false' do
          relationship()
          expect(described_class).not_to be_entry_found(3, 4)
        end
      end
    end
  end

  describe '.friend_entries' do
    let(:social_user) { create(:user, id: 1) }
    let(:first_friend) { create(:user, id: 2) }
    let(:second_friend) { create(:user, id: 3) }
    let(:create_relationships) do
      first_relationship()
      second_relationship()
    end

    context 'when a user has friend relationships' do
      let(:first_relationship) { create(:relationship, requester: social_user, requested: first_friend, relationship_type: 'friends') }
      let(:second_relationship) { create(:relationship, requester: second_friend, requested: social_user, relationship_type: 'friends') }

      it 'returns a list of said relationships' do
        create_relationships()
        expect(described_class.friend_entries(1)).to contain_exactly(Relationship, Relationship)
      end
    end

    context 'when a user does not' do
      let(:first_relationship) { create(:relationship, requester: social_user, requested: first_friend, relationship_type: 'pending') }
      let(:second_relationship) { create(:relationship, requester: second_friend, requested: social_user, relationship_type: 'pending') }

      context 'have friend relationships' do
        it 'returns an empty array' do
          create_relationships()
          expect(described_class.friend_entries(1)).to be_empty
        end
      end
      
    end
  end

  describe '.requester_friends' do
    let(:social_user) { create(:user, id: 1) }
    let(:first_requester) { create(:user, id: 2) }
    let(:second_requester) { create(:user, id: 3) }
    let(:create_relationships) do
      first_relationship()
      second_relationship()
    end

    context 'when user has friends' do
      let(:first_relationship) { create(:relationship, requester: first_requester, requested: social_user, relationship_type: 'friends') }
      let(:second_relationship) { create(:relationship, requester: second_requester, requested: social_user, relationship_type: 'friends') }

      it 'returns list of requester ids' do
        create_relationships()
        expect(described_class.requester_friends(1)).to match_array(
          [
            have_attributes("requester_id" => first_requester.id),
            have_attributes("requester_id" => second_requester.id),
          ]
        )
      end
    end

    context 'when user has no friends' do
      let(:first_relationship) { create(:relationship, requester: first_requester, requested: social_user, relationship_type: 'pending') }
      let(:second_relationship) { create(:relationship, requester: second_requester, requested: social_user, relationship_type: 'pending') }

      it 'returns an empty array' do
        create_relationships()
        expect(described_class.requester_friends(1)).to be_empty
      end
    end
  end

  describe '.requested_friends' do
    let(:social_user) { create(:user, id: 1) }
    let(:first_requested) { create(:user, id: 2) }
    let(:second_requested) { create(:user, id: 3) }
    let(:create_relationships) do
      first_relationship()
      second_relationship()
    end

    context 'when user has friends' do
      let(:first_relationship) { create(:relationship, requester: social_user, requested: first_requested, relationship_type: 'friends') }
      let(:second_relationship) { create(:relationship, requester: social_user, requested: second_requested, relationship_type: 'friends') }

      it 'returns list of requester ids' do
        create_relationships()
        expect(described_class.requested_friends(1)).to match_array(
          [
            have_attributes("requested_id" => first_requested.id),
            have_attributes("requested_id" => second_requested.id),
          ]
        )
      end
    end

    context 'when user has no friends' do
      let(:first_relationship) { create(:relationship, requester: social_user, requested: first_requested, relationship_type: 'pending') }
      let(:second_relationship) { create(:relationship, requester: social_user, requested: second_requested, relationship_type: 'pending') }

      it 'returns an empty array' do
        create_relationships()
        expect(described_class.requested_friends(1)).to be_empty
      end
    end
  end

  describe '.friends' do
    let(:social_user) { create(:user, id: 1) }
    let(:first_requested) { create(:user, id: 2) }
    let(:second_requested) { create(:user, id: 3) }
    let(:create_relationships) do
      first_relationship()
      second_relationship()
    end

    context 'when a user has friends' do
      let(:first_relationship) { create(:relationship, requester: social_user, requested: first_requested, relationship_type: 'friends') }
      let(:second_relationship) { create(:relationship, requester: social_user, requested: second_requested, relationship_type: 'friends') }

      it 'returns an array of user ids' do
        create_relationships()
        expect(described_class.friends(1)).to contain_exactly(2, 3)
      end
    end

    context 'when a user has no friends' do
      let(:first_relationship) { create(:relationship, requester: social_user, requested: first_requested, relationship_type: 'pending') }
      let(:second_relationship) { create(:relationship, requester: social_user, requested: second_requested, relationship_type: 'pending') }

      it 'returns an empty array' do
        create_relationships()
        expect(described_class.friends(1)).to be_empty
      end
    end
  end
end