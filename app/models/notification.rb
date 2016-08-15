class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :read_at, type: DateTime
  field :notify_type, type: String

  belongs_to :actor, polymorphic: true
  belongs_to :user
  belongs_to :target, polymorphic: true

  scope :unread, -> { where(read_at: nil) }


  def read?
    self.read_at.present?
  end

  def self.read!(ids = [])
    return if ids.blank?
    Notification.where(id: ids).update_all(read_at: Time.now)
  end

  def self.unread_count(user)
    Notification.where(user: user).unread.count
  end
end
