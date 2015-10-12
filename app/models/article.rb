require 'will_paginate/array'


class Article
  include Mongoid::Document
  field :title, type: String
  field :content, type: String

  validates :title, presence: true

  belongs_to :user

end
