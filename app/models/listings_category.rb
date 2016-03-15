class ListingsCategory < ActiveRecord::Base
  belongs_to :listing
  belongs_to :category
end
