class Post < ActiveRecord::Base
    has_and_belongs_to_many :tags       # foreign keys in the join table
    acts_as_commontable dependent: :destroy
    acts_as_votable
    belongs_to :student 
end