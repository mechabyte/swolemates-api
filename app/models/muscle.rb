class Muscle < ActiveRecord::Base
  has_many :exercises, inverse_of: :muscle

  default_scope { order('name ASC') }
end
