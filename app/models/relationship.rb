class Relationship < ApplicationRecord
  validates :requester_id, presence: true, uniqueness: { scope: :requested_id }
  validates :requested_id, presence: true
  validates :relationship_type, presence: true
  validate :validate_inverse_friend_request_uniqueness
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"

  def validate_inverse_friend_request_uniqueness
    if Relationship.find_by(requester_id: requested.id, requested_id: requester.id)
      errors.add(:base, "Inverse combination already exists")
    end
  end

  def self.entry_found?(user_id1, user_id2)
    Relationship.find_by(requester_id: user_id1, requested_id: user_id2) ? true : false
  end

  def self.friend_request_sent?(user_id1, user_id2)
    entry_found?(user_id1, user_id2)
  end

  def self.friend_request_received?(user_id1, user_id2)
    entry_found?(user_id2, user_id1)
  end
end
