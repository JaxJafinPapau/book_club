class Author < ApplicationRecord
    validates_presence_of :name
    has_many :bookauthors
    has_many :books, through: :bookauthors

    before_save { self.name = self.name.titleize }
end
