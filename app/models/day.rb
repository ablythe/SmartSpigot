class Day < ActiveRecord::Base
  belongs_to :user
  belongs_to :spigot
end
