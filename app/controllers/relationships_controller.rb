class RelationshipsController < ApplicationController
  def new
    @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      redirect_to root_path
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:requester_id, :requested_id, :relationship_type)
  end
end
