class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :email, uniqueness: true, email_format: true

end
