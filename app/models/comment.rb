class Comment < ApplicationRecord
  belongs_to :prototype
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :text, presence: true
end
