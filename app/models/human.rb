require 'will_paginate/array'

class Human
  include Mongoid::Document
  include Mongoid::Timestamps


  field :realname, type: String
  field :birthday, type: DateTime
  field :sex, type: Integer
  field :work, type: String
  field :avatar, type: String

  has_many :up_relations, class_name: 'HumanRelation', inverse_of: :down_relation
  has_many :down_relations, class_name: 'HumanRelation', inverse_of: :up_relation




  def qiniu_image_url(format = :raw)
    url = "http://7xokus.com2.z0.glb.qiniucdn.com/#{self.avatar}"
     
    case format
      when :square
        url << '?imageView2/1/w/300/h/300/q/90'
      when :preview
        url << '?imageView2/2/w/1000/h/1000/q/90'
      when :raw
        url << "?attname=#{self.realname}"
      else
        url
      end
    end
end
