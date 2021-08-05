class ChangeSubscriptionsRemoveForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_reference :subscriptions, :customer
  end
end
