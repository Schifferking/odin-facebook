require 'rails_helper'
require 'support/shared_contexts/login_user'

RSpec.describe Relationship, type: :request do
  include_context :login_user

  let(:requested_user) { create(:user) }
  let(:valid_attributes) do
    { requester_id: user.id, requested_id: requested_user.id, relationship_type: 'pending' }
  end

  let(:invalid_attributes) do
    { requester_id: user.id, requested_id: requested_user.id, relationship_type: nil }
  end

  describe 'POST /relationships' do
    context 'with valid attributes' do
      it 'redirects to root_path' do
        post relationships_url, params: { relationship: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable_entity http status' do
        post relationships_url, params: { relationship: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /relationships/:id' do
    context 'with valid attributes' do
      let(:new_attributes) do
        { requester_id: user.id, requested_id: requested_user.id, relationship_type: "friends" }
      end

      it 'changes relationship_type' do
        relationship = create(:relationship, valid_attributes)
        expect do 
          patch relationship_url(relationship), params: { relationship: new_attributes }
          relationship.reload
        end.to \
          change(relationship, :relationship_type)
          .from("pending")
          .to("friends")
      end

      it 'redirects to root_path' do
        relationship = create(:relationship, valid_attributes)
        patch relationship_url(relationship), params: { relationship: new_attributes }
        relationship.reload
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable_entity http status' do
        relationship = create(:relationship, valid_attributes)
        patch relationship_url(relationship), params: { relationship: invalid_attributes }
        relationship.reload
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /relationships/:id' do
    it 'destroys the requested relationship' do
      relationship = create(:relationship, valid_attributes)
      expect { delete relationship_url(relationship) }.to change(Relationship, :count).by(-1)
    end
  end
end