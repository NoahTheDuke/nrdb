class CyclesController < ApplicationController
  before_action :admin_user, only: %i[index edit update destroy show create new]

  def index
    @cycles = Cycle.all.order(:name).paginate(page: params[:page])
  end

  def show
    @cycle = Cycle.find(params[:id])
    return if @cycle.present?

    redirect_to cycles_path
  end

  def new
    @cycle = Cycle.new
  end

  def edit
    @cycle = Cycle.find(params[:id])
    return if @cycle.present?

    redirect_to cycles_path
  end

  def create
    @cycle = Cycle.new(cycle_params)

    respond_to do |format|
      if @cycle.save
        format.html { redirect_to @cycle, notice: 'Cycle was successfully created.' }
        format.json { render :show, status: :created, location: @cycle }
      else
        format.html { render :new }
        format.json { render json: @cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cycle = Cycle.find(params[:id])
    if @cycle.update(cycle_params)
      flash[:success] = 'Cycle updated'
      redirect_to @cycle
    else
      render 'edit'
    end
  end

  def destroy
    Cycle.find(params[:id]).destroy
    flash[:success] = 'Cycle deleted'
    redirect_to cycles_url
  end

  private

  def set_cycle
    @cycle = Cycle.find(params[:id])
  end

  def cycle_params
    params.require(:cycle).permit(:code, :name)
  end

  def admin_user
    redirect_to(root_url) unless current_user&.admin?
  end
end
