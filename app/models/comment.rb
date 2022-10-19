class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :member

  validates :comment, length: {  maximum: 100 }, presence: true
end
