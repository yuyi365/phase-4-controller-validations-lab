class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid,
              with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def show
    post = find_post
    render json: post
  end

  def update
    post = find_post
    post.update!(post_params)
    render json: post
  end

  private

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {
             errors: invalid.record.errors,
           },
           status: :unprocessable_entity
  end
end
