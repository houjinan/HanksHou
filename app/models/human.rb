require 'will_paginate/array'

class Human
  include Mongoid::Document
  include Mongoid::Timestamps


  field :realname, type: String
  field :birthday, type: DateTime
  field :sex, type: Integer
  field :work, type: String

  has_many :up_relations, class_name: 'HumanRelation', inverse_of: :down_relation
  has_many :down_relations, class_name: 'HumanRelation', inverse_of: :up_relation
end
