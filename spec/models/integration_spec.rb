require 'spec_helper'

describe Integration do
  describe 'Validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :account_id }
    it { should validate_presence_of :access_token }
    it { should validate_presence_of :access_secret }
    it { should validate_uniqueness_of :user_id }
  end

  describe 'Associations' do
    it { should belong_to :user }
  end
end