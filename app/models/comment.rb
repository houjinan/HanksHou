require 'will_paginate/array'

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  validates :content, presence: true
  belongs_to :user
  belongs_to :article

  private 

end
