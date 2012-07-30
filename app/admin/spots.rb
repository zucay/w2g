ActiveAdmin.register Spot do
  scope :deny
  scope :inputed
  scope :active
  scope :good
  filter :project
  filter :name
  filter :pref
  filter :addr
  filter :tel
  filter :linenum
  filter :gid
  filter :created_at
  filter :updated_at
  show do |spot|
    src = "http://jjworkshop.com/cgi-bin/gmap/map.cgi?lat=#{spot.lat_world}&lng=#{spot.lng_world}&sc=16&w=600&h=340&sm=1&memo=&url=&fsp=80&mpc=1&msc=1&mtc=1&mov=1&mtp=0"
    iframe :src => src.html_safe, :width => 600, :height => 340, :frameborder => '0', :scrolling => 'off', :style => 'border:1px solid #888888;margin:0px 0px 0px 0px;' do end
    default_main_content
  end
end
