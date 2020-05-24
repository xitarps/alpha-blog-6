class PagesController < ApplicationController
  before_action :fetch_categories
  def home
    redirect_to articles_path if logged_in?
  end

  def about
  end

  def search
    if !params[:search].empty? && @search_text = params[:search]
      @articles = Article
                    .where("lower(title) LIKE ?",
                           "%#{@search_text.downcase}%")
                      .or(Article
                            .where("lower(description) LIKE ?",
                                  "%#{@search_text.downcase}%"))
                              .paginate(page: params[:page], per_page: 5)
                              .order('created_at DESC')
    else
      @articles = []
    end
  end

end