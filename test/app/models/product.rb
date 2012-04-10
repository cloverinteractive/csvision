class Product < ActiveRecord::Base
  validates_presence_of :name, :permalink, :description
  add_csvision :except => %w/updated_at created_at/
end
