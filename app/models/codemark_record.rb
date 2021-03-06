class CodemarkRecord < ActiveRecord::Base
  belongs_to :link_record
  belongs_to :user

  has_many :codemark_topics, :dependent => :destroy
  has_many :topics, :through => :codemark_topics
  has_many :comments, :foreign_key => 'codemark_id'

  validates_presence_of :link_record
  validates_presence_of :user

  scope :unarchived, where(['archived = ?', false])
  scope :by_save_date, order('created_at DESC')
  scope :by_popularity, joins(:link).order('clicks_count DESC')
  scope :for, lambda { |links| includes(:link).where(['link_id in (?)', links]) }

  delegate :url, :to => :link_record

  def self.for_user_and_link(user, link_record)
    where(:user_id => user.id).where(:link_record_id => link_record.id).first
  end

  def resource_author
    link_record.author if link_record
  end

  #def private?
    #private_topic = Topic.find_by_title('private')
    #topics.include? private_topic
  #end
end
