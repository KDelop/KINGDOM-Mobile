class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:phone_number]

  has_many :leads
  has_many :demos
  has_many :availabilities

   enum status: { inactive: 0, active: 1 }
   # validates :phone_number, phone: true, uniqueness: true
   # validates :phone_number, format: { with: /\A\+(?:[0-9]●?){6,14}[0-9]\z/,
   #                                    message: 'Invalid phone format' }

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  def is_active?
    return status == "active" ? true : false
  end 
end
