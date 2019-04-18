class NrSetsController < ApplicationController
  def index
    @nr_sets = NrSet.includes(:nr_set_type).all.order(:date_release).paginate(page: params[:page])
  end

  def show
    @nr_set = NrSet.find(params[:id])
    return if @nr_set.present?

    redirect_to nr_sets_path
  end

  def new
    @nr_set = NrSet.new
  end

  def edit
    @nr_set = NrSet.find(params[:id])
    return if @nr_set.present?

    redirect_to nr_sets_path
  end

  def create
    @nr_set = NrSet.new(nr_set_params)
    if @nr_set.save
      flash[:info] = 'Set created'
      redirect_to @nr_set
    else
      render 'new'
    end
  end

  def update
    @nr_set = NrSet.find(params[:id])
    if @nr_set.update(nr_set_params)
      flash[:success] = 'Set updated'
      redirect_to @nr_set
    else
      render 'edit'
    end
  end

  def destroy
    NrSet.find(params[:id]).destroy
    flash[:success] = 'Set deleted'
    redirect_to cycles_url
  end

  private

  def set_nr_set
    @nr_set = NrSet.find(params[:id])
  end

  def nr_set_params
    params.require(:nr_set).permit(:code, :name, :cycle_id, :date_release, :size,
                                   :nr_set_type_id)
  end
end
