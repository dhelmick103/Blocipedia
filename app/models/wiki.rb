class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators
  scope :visible_to, -> (user) { user ? all : where(private: false) }

  self.per_page = 20

  def public?
    private == false
  end

  def owner
    self.user
  end
end
