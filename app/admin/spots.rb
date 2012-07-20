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
end
