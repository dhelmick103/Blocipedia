class WikisController < ApplicationController
  before_action :authenticate_user!, except: :show
 # require sign_in :require_sign_in, except: [:show]
  # before_action :authorize_user, except: [:index, :show, :new, :create]

  def index
    @wikis = Wiki.all
    @user = current_user
  end

  def new
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def create
    @wiki = Wiki.create(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating your wiki."
      redirect_to :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    if current_user != @wiki.user && !current_user.admin?
      redirect_to @wiki
    end
  end

  def destroy

    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" has been deleted."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting your Wiki. Please try again."
      # render :show
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was successfully updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error editing the post. Please try again."
      redirect_to :edit
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    if current_user.nil?
      flash[:alert] = "You must be an admin to do that."
      redirect_to new_user_session_path
    end
  end
end
