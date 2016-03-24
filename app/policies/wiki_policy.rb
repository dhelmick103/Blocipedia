class WikiPolicy < ApplicationPolicy

  def destroy?
    user.present? && (user == record.user || user.admin?)
  end

  def create?
    user.present?
  end

  def index?
    true
  end

  def edit?
    user.present?
  end

  def update?
    user.present?
  end

  def show?
    private_authentication
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  end
end
