require 'will_paginate/array'

class AuthToken

  include Mongoid::Document

  field :token_value, type: String, default: ""
  field :expire_at, type: DateTime
  belongs_to :user

  before_create :generate_token

  def generate_token
    begin
      self.token_value = SecureRandom.hex
    end while self.class.where(token_value: self.token_value).present?
  end
end