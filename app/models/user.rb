class User < ApplicationRecord
  #before saving user object, downcase all the letter in the user's email 
  before_save { self.email = email.downcase } 

  #User can have many articles
  has_many :articles, dependent: :destroy 
  #dependent: :destroy, means if use delete their account, destroy all articles associated with that user

  validates :username, presence: true, 
             uniqueness: { case_sensitive: false },  
             length: { minimum: 3, maximum: 25 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, 
             uniqueness: { case_sensitive: false },
             length: { maximum: 105 },
             format: {with: VALID_EMAIL_REGEX}

  has_secure_password  # This active bycrpt functionalities to user model


end


# uniqueness: true ==> This will not check for case sensitivity. Meaning Aaa != aaa. Meaning username can be Aaa or aaa.

# uniqueness: { case_sensitive: false }  ==> Meaning Aaa == aaa. Meaning if one username is Aaa another username can't be aaa.

# BCrypt::Password.create(enter-your-password-to-hash-here)
# Bcrypt code to create a hashed password from the console.
# user,authenticate(provide-the-password-to-check)
# use rails "authenticate" to check of provided password is equal to hashed password