class Communication < ActiveRecord::Base
  belongs_to :spot
  belongs_to :caretaker
end
