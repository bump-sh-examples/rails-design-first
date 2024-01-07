class WidgetsController < ApplicationController
  before_action :set_widget, only: %i[ show update destroy ]

  # GET /widgets
  def index
    @widgets = Widget.all

    if stale?(@posts)
      render json: @widgets
    end
  end

  # GET /widgets/1
  def show
    if stale?(@posts)
      render json: @widget
    end
  end

  # POST /widgets
  def create
    @widget = Widget.new(widget_params)

    if @widget.save
      render json: @widget, status: :created, location: @widget
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /widgets/1
  def update
    if @widget.update(widget_params)
      render json: @widget
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  # DELETE /widgets/1
  def destroy
    @widget.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def widget_params
      # params.require(:widget).permit(:name)
      params.permit(:name)
    end
end
