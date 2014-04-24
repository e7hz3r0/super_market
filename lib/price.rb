class Price
  include ActiveModel::Model
  attr_accessor :price_in_cents, :for_quantity, :quantity_for_free

  # Constuctor: defines a price that can either be:
  #   a) N items for X cents
  #   b) Buy N at X cents each, get M items free
  # price_in_cents - the price in cents for 
  #   a) for_quantity in total, if quantity_for_free is 0 or 
  #   b) for EACH item in for_quantity if quantity_for_free > 0
  # for_quantity - the number that 
  #   a) will cost price_in_cents if bought at the same time (if quantity_for_free is 0
  #   b) will each cost price_in_cents but if this number is purchase, you can get quantity_for_Free items at no charge
  # quantity_for_free - the number of items to get for free if for_quantity items are purchased. Defaults to 0
  # is_quantity_required - determines if for_quantity items MUST be bought to get the sale price
  def initialize(price_in_cents, for_quantity = 1, quantity_for_free = 0, is_quantity_required = false)
    self.price_in_cents = price_in_cents
    self.for_quantity = for_quantity
    self.quantity_for_free = quantity_for_free
    @is_quantity_required = is_quantity_required
  end

  # Return the total price for the given quantity of items
  # If this price object requires a given number of items HAVE to be purchased and they aren't it raises a RuntimeError
  def price_for(quantity)
    total_req_quantity = self.for_quantity + self.quantity_for_free
    price_per_unit = Float(self.price_in_cents) / Float(self.for_quantity) #default to the sale price for set # of items

    if (quantity_required? && quantity.modulo(total_req_quantity) != 0)
        raise "Invalid quantity supplied (#{quantity}) when specific quantity is required. Expected #{self.for_quantity + self.quantity_for_free}."
    elsif (self.quantity_for_free > 0)
      price_per_unit = self.price_in_cents
    end
    (price_per_unit * quantity).ceil - (quantity/total_req_quantity) * (price_per_unit * self.quantity_for_free).ceil
  end

  # Returns whether a set number of items MUST be purchased in order to get the sale price
  def quantity_required?
    @is_quantity_required || self.quantity_for_free > 0
  end
end
