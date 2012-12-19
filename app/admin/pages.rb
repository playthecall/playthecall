# encoding: utf-8
ActiveAdmin.register Page do
  menu :label => 'Pages'

  filter :name
  filter :locale

  #scope :admin_order

  index do
    column :name
    column :locale
    column :created_at
    default_actions
  end
end

