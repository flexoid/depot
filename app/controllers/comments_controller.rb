class CommentsController < ApplicationController
  load_and_authorize_resource :product
  load_and_authorize_resource :comment, through: :product

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  def create
    @comment.user = current_user
    @comment.parent_id = Comment.find_by_id(@comment.parent_id).try(:id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to "#{url_for(@comment.product)}#comment-#{@comment.id}",
                      notice: 'Comment was successfully posted.' }
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
