class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid,
              with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def show
    author = find_author
    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created
  end

  private

  def find_author
    Author.find(params[:id])
  end

  def author_params
    params.permit(:email, :name)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {
             errors: invalid.record.errors,
           },
           status: :unprocessable_entity
  end
end
