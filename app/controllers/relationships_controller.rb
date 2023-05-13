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

  def index
    @relationships = Relationship.where(requested_id: current_user.id)
  end

  def update
    @relationship = Relationship.find(params[:id])
    if @relationship.update(relationship_params)
      redirect_to root_path
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
  end

  private

  def relationship_params
    params.require(:relationship).permit(:requester_id, :requested_id, :relationship_type)
  end
end
