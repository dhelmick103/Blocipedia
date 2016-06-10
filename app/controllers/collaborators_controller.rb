class CollaboratorsController < ApplicationController
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @user = User.all
  end

  def show
    @collaborator = Collaborator.find(params[:wiki])
  end

  def create

    @wiki = Wiki.find(params[:wiki_id])
    # @collaborator = Collaborator.new(user_id: params[:user_id], wiki_id: params[:wiki_id])
    # @collaborator.wiki = @wiki

    @user = User.where(email: params[:email]).first

    #if there is no user, raise error
    #if user, and there is already colalborator, raise error
    #if user, and user == current_user
    #if user, and no collaorator, raise success and create collaborator

    if !@user
      flash[:error] = "There is no user with that email"
    elsif @user && Collaborator.where(user: @user, wiki: @wiki).first
      flash[:error] = "This user is already a collaborator"
    elsif @user == current_user
      flash[:error] = "You can't add yourself as a collaborator"
    elsif Collaborator.create(user: @user, wiki: @wiki)
      flash[:notice] = "Collaborator added"
    else
      flash[:error] = "CSomething went wrong"
    end
    redirect_to edit_wiki_path(@wiki)
  end


  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "You removed the collaborator."
    else
      flash[:alert] = "You did not remove the collaborator."
    end
    redirect_to edit_wiki_path(@wiki)

  end

  private
  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
