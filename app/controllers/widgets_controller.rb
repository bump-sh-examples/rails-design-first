class WidgetsController < ApplicationController

  # GET /widgets
  def index
    widgets = Widget.all

    if stale? widgets
      render json: widgets
    end
  end

  # GET /widgets/:id
  def show
    widget = Widget.find(params[:id])

    if stale? widget
      render json: widget
    end
  rescue ActiveRecord::RecordNotFound
    render problem: { detail: 'The requested widget does not exist.' }, status: :not_found
  end

  # POST /widgets
  def create
    widget = Widget.new(widget_params)

    if widget.save
      render location: widget, status: :created
    else
      render problem: { errors: widget.errors }, status: :bad_request
    end
  end

  # PUT /widgets/:id
  def update
    widget = Widget.find(params[:id])

    if widget.update(widget_params)
      render json: widget
    else
      render problem: { errors: widget.errors }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render problem: { detail: 'The requested widget does not exist.' }, status: :not_found
  end

  # DELETE /widgets/:id
  def destroy
    widget = Widget.find(params[:id])

    widget.destroy!
  rescue ActiveRecord::RecordNotFound
    render problem: { detail: 'The requested widget does not exist.' }, status: :not_found
  end

  private
  
  # Only allow a list of trusted parameters through.
  def widget_params
    params.require(:widget).permit(:name)
  end
end
