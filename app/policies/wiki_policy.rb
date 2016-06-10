class WikiPolicy < ApplicationPolicy

  def destroy?
    user && (user == record.user || user.admin?)
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && (record.private != true || record.user == user)
  end

  def update?
    edit?
  end

  def show?

    record.private != true || record.user == user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      puts "resolving"
      wikis = []
      if user.admin?
        puts "admin user"
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          puts "in all wikis loop"
          if wiki.public? || (wiki.owner == user || wiki.collaborators.include?(user))
            puts "adding wiki"
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      puts "resolved"
      wikis # return the wikis array we've built up
    end
  end
 end
