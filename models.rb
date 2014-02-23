class List < ActiveRecord::Base

end

class Item < ActiveRecord::Base

end

class User < ActiveRecord::Base
  # validates :username, uniqueness: true
end