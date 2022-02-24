class User < ApplicationRecord
  #before saving user object, downcase all the letter in the user's email 
  before_save { self.email = email.downcase } 

  has_many :articles #User can have many articles

  validates :username, presence: true, 
             uniqueness: { case_sensitive: false },  
             length: { minimum: 3, maximum: 25 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, 
             uniqueness: { case_sensitive: false },
             length: { maximum: 105 },
             format: {with: VALID_EMAIL_REGEX}


end


# uniqueness: true ==> This will not check for case sensitivity. Meaning Aaa != aaa. Meaning username can be Aaa or aaa.

# uniqueness: { case_sensitive: false }  ==> Meaning Aaa == aaa. Meaning if one username is Aaa another username can't be aaa.