require 'rails_helper'

RSpec.describe SubscriptionTea, type: :model do
  describe 'relationships' do
    it {should belong_to :subscription}
    it {should belong_to :tea}
  end

  describe 'validations' do
    it {should validate_presence_of :subscription}
    it {should validate_presence_of :tea}
  end
end