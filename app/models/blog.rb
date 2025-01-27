class Blog < ApplicationRecord
  has_one_attached :thumbnail#コメントアウトを外す
  #has_one_attached :image
end
