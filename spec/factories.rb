# -*- coding: utf-8 -*-
require 'factory_girl'

FactoryGirl.define do
  factory :midtown_j, class:Spot do
    name 'midtown'
    addr '東京都港区赤坂９丁目７－３'
    lat_256jp 32866409
    lng_256jp 128778567
  end
  factory :skytree_j, class:Spot do
    name 'skytree'
    addr '東京都墨田区押上1'
    lat_256jp 32907327
    lng_256jp 128852521
  end
  factory :project_j, class:Project do 
    name 'project_a'
    spots do 
      [FactoryGirl.build(:midtown_j), FactoryGirl.build(:skytree_j)]
    end
  end
end
