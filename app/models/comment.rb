require 'will_paginate/array'

class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  validates :content, presence: true
  belongs_to :user
  belongs_to :article


  after_create :create_notifications

  private
    def create_notifications
      notification = Notification.create(
        notify_type: 'comment',
        actor: self.user,
        user: self.article.user,
        target: self)
    end
end
