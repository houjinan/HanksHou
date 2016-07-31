require 'will_paginate/array'

class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :visit_count, type: Integer, default: 0

  field :article_type, type: String, default: "technique"
  validates :title, presence: true
  belongs_to :user, inverse_of: :articles
  has_many :comments
  has_and_belongs_to_many :labels, :counter_cache => true
  has_and_belongs_to_many :collection_users, class_name: 'User', inverse_of: :collection_articles

  ArticleType = [["技术文章", "technique"], ["心得体会", "experience"], ["读书感", "reading"], ["旅行笔记", "travel"]]
  def labels_content
    self.labels.collect { |label| label.name }.join(", ")
  end

  def self.default_type
    "technique"
  end

  def article_type_name
    type_names = ArticleType.select{|type| type[1] == self.article_type}
    type_names.present? ? type_names.first[0] : ""
  end

  private

end
