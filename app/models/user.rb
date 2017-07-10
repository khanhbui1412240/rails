class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :confirmable
  has_many :blogs , :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, :dependent => :destroy
  protected
  def confirmation_required?
    true
  end
end
