class ArticleCategory < ApplicationRecord

  # for many-to-many association, this will belongs to both article and category
  belongs_to :article
  belongs_to :category

end