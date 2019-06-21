require 'will_paginate/array'

class User
  # include Paperclip::Glue
  include Mongoid::Paperclip
  # include Mongoid::Carrierwave
  include Mongoid::Document
  include Mongoid::Timestamps
  rolify

  default_scope { desc(:created_at) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :nickname, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  # field :head_avatar, type: String, default: ""

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :is_deleted, type: Boolean, default: false

  has_many :articles, inverse_of: :user
  has_and_belongs_to_many :collection_articles, class_name: 'Article', inverse_of: :collection_users
  has_and_belongs_to_many :vote_articles, class_name: 'Article', inverse_of: :vote_users

  has_many :notifications, dependent: :destroy
  has_many :auth_tokens, dependent: :destroy

  validates :nickname, presence: {message: "昵称不能为空"}
  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  #
  #

  # has_mongoid_attached_file :head_avatar, styles: { medium: "300x300>", thumb: "100x100>" }, :default_url => ActionController::Base.helpers.asset_path('default_head.png')
  # validates_attachment_content_type :head_avatar, content_type: /\Aimage\/.*\Z/

  mount_uploader :head_avatar, HeadAvatarUploader

  alias will_save_change_to_email? email_changed?
  def is_super_admin?
    # email == "houjinan@126.com" ? true : false
    self.has_role? :admin
  end


  def user_name
    self.nickname.present? ? self.nickname : self.email
  end

  def calendar_data
    date_from = 12.months.ago.beginning_of_month.to_date
    data_articles = self.articles.where(:created_at.gte => date_from).group_by{|d| d.created_at.to_date}
    timestamps = {}
    data_articles.each do |date, articles|
      timestamps[date.to_time.to_i.to_s] = articles.size
    end
    timestamps
  end
end
