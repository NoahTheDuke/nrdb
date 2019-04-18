class CardsController < ApplicationController
  def index
    @cards = Card.includes(%i[side faction card_type subtypes])
                 .all
                 .order(:code)
                 .paginate(page: params[:page])
  end

  def show
    @card = Card.find_by(code: params[:code])
    return if @card.present?

    redirect_to cards_path
  end
end
