class WikiPolicy < ApplicationPolicy

  def destroy?
    user && (user == record.user || user.admin?)
  end

  def create?
    user.present?
  end

  def index?
    true
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
  end
end
