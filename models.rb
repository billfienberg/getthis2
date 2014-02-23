class List < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :customer
end

class User < ActiveRecord::Base
  has_and_belongs_to_many :lists
end