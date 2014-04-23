class Price
  include ActiveModel::Model
  attr_accessor :price_in_cents, :for_quantity

  def initialize(price_in_cents, for_quantity = 1, is_quantity_required = false)
    self.price_in_cents = price_in_cents
    self.for_quantity = for_quantity
    @is_quantity_required = is_quantity_required
  end

  def price_for(quantity)
    ((Float(self.price_in_cents) / Float(self.for_quantity)) * quantity).ceil
  end

  def quantity_required?
    @is_quantity_required
  end
end
