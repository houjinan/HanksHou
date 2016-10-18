require 'will_paginate/array'

class HumanRelation
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, type: String
  belongs_to :up_relation, class_name: 'Human', inverse_of: :down_relations
  belongs_to :down_relation, class_name: 'Human', inverse_of: :up_relation
end