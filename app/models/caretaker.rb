class Caretaker < ActiveRecord::Base
  has_many :communications
  has_many :spots
end
