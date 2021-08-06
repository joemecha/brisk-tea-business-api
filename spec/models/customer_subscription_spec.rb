require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should belong_to :subscription}
  end
  describe 'validations' do
    it {should validate_presence_of :customer}
    it {should validate_presence_of :subscription}
  end
end
