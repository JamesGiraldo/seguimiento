class User < ApplicationRecord

  rolify

  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
  def assign_default_role
     add_role(:aprendiz) if self.roles.blank?
  end

  belongs_to :tipodocumento

  has_many :anotaciones, as: :anotable

  belongs_to :ficha

end
