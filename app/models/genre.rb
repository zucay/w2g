class Genre < ActiveRecord::Base
  attr_accessible :active, :name, :position, :public
  has_many :projects
end
