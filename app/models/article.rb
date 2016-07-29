require 'will_paginate/array'

class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :visit_count, type: Integer, default: 0

  field :article_type, type: String, default: "technique"
  validates :title, presence: true
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :labels, :counter_cache => true

  ArticleType = [["技术", "technique"], ["心得", "experience"], ["读书", "reading"], ["旅行", "travel"]]
  def labels_content
    self.labels.collect { |label| label.name }.join(", ")
  end

  def self.default_type
    "technique"
  end

  private

end
