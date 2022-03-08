class Article < ApplicationRecord
    # for ==> has-many-association
    belongs_to :user

    # for ==> many-to-many-association
    has_many :article_categories
    has_many :categories, through: :article_categories 

    #check these validations before saving article
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
end

# ==> Article.update_all(user_id: User.first.id)
# From the console, we can assign all articles created before adding user_id column to articles table to a user using the command above
