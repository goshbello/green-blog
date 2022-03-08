class Category < ApplicationRecord

  # for ==> many-to-many-association
  has_many :article_categories
  has_many :articles, through: :article_categories 

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :name, uniqueness: { case_sensitive: false }

end