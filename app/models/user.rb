class User < ApplicationRecord

  acts_as_paranoid

  has_one_attached :image
  has_many :comments
  has_many :articles
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :trackable

  belongs_to :role
  after_initialize :default_role

  def is_admin?
    role.name == "admin"
  end

  def is_moderator?
    role.name == "moderator"
  end

  def is_commenter?
    role.name == "commenter"
  end

  def is_editor?
    role.name == "editor"
  end

  private

  def default_role
    if self.role.blank?
      if Role.default.any?
        self.role = Role.default.first
      end
    end
  end
end
