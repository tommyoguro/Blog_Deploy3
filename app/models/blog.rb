class Blog < ApplicationRecord
  #has_one_attached :thumbnail#コメントアウト
  has_one_attached :image
end
