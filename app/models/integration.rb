class Integration < ActiveRecord::Base
  validates :user_id, presence: true, numericality: true
  validates :account_id, presence: true, numericality: true
  validates :token, presence: true
  validates_uniqueness_of :user_id, :scope => [:account_id]

  attr_encrypted :token, :username, :secret, key: :encryption_key

  belongs_to :user
  belongs_to :account

  scope :twitter, -> { where(account: Account.find_by_name('Twitter')).first }

  include GithubHelper
  include Encryptable


  def todays_events
    rdb[user.current_time.to_date].get
  end

  def todays_events=(events)
    rdb[user.current_time.to_date].set events
    rdb[user.current_time.to_date].expire 86400 # delete after 1 day
  end

end

#     Column     |            Type             |                         Modifiers
# ---------------+-----------------------------+-----------------------------------------------------------
#  id            | integer                     | not null default nextval('integrations_id_seq'::regclass)
#  user_id       | integer                     |
#  account_id    | integer                     |
#  access_token  | character varying(255)      |
#  access_secret | character varying(255)      |
#  created_at    | timestamp without time zone |
#  updated_at    | timestamp without time zone |
#  username      | character varying(255)      |
# Indexes:
#     "integrations_pkey" PRIMARY KEY, btree (id)
#     "index_integrations_on_user_id_and_account_id" btree (user_id, account_id)