class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 75 }
  validates :page_count, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :pub_year, presence: true, numericality: {greater_than: 1000, less_than: 2030, only_integer: true}

  has_many :reviews, dependent: :destroy
  has_many :bookauthors, dependent: :destroy
  has_many :authors, through: :bookauthors

  before_save { self.title = self.title.titleize }
  before_save {
    if self.thumbnail_url == ""
      self.thumbnail_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd3cgsv8lMoNU4g8dDN1hUqKlXAR3DTITUd5rl1tMuYds_wAP6"
    end
  }

  def highest_three_reviews
    reviews.order(:score).last(3).reverse
  end

  def lowest_three_reviews
    reviews.order(:score).first(3)
  end

  def average_review_score
    raw_mean = reviews.average(:score).to_f
    raw_mean.round(2)
  end

  def review_count
    reviews.count
  end

  def coauthors(excluded_author)
    authors.where.not(id: excluded_author.id)
  end

  def self.descending_pages
    Book.order(page_count: :desc)
  end

  def self.ascending_pages
    Book.order(page_count: :asc)
  end

  def self.descending_rating
    Book.all.sort_by do |book|
      book.average_review_score
    end.reverse
  end

  def self.ascending_rating
    Book.all.sort_by do |book|
      book.average_review_score
    end
  end

  def self.descending_reviews
    Book.all.sort_by do |book|
      book.review_count
    end.reverse
  end

  def self.ascending_reviews
    Book.all.sort_by do |book|
      book.review_count
    end
  end

  def self.highest_three_scores
    highest_scores = Book.all.sort_by do |book|
       book.average_review_score
     end.reverse
     highest_scores[0..2]
  end

  def self.lowest_three_scores
    lowest_scores = Book.all.sort_by do |book|
       book.average_review_score
     end
    lowest_scores[0..2]
  end
end
