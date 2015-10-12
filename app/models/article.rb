require 'will_paginate/array'

class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String

  validates :title, presence: true
  belongs_to :user




  private 

end
