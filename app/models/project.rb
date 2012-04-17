require 'mymatrix'
class Project < ActiveRecord::Base
  has_many :spots
  belongs_to :header

  def load(file)
    mx = MyMatrix.new(file)
    mx.getHeaders.each do |head|
      if()
      else
        #notfound
      end
    end
  end
end
