require 'will_paginate/array'

class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :visit_count, type: Integer, default: 0

  validates :title, presence: true
  belongs_to :user
  has_and_belongs_to_many :labels


  def labels_content
    self.labels.collect { |label| label.name }.join(", ")
  end

  private 

end
