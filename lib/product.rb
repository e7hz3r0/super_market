class Product
  include ActiveModel::Model
  attr_accessor :regular_price, :sale_price

  # Constructor - takes a Price object describing this products regular price
  def initialize(regular_price)
    self.regular_price = regular_price
  end

  # Purchase the given quantity of this product
  # Returns the total cost
  # If the price requires the exact quantity to get the price (3 for $1.00, must buy 3):
  # - If you buy less than the required amount, the regular price is used
  # - If you buy more, then the sale price is used for the maximum number of items that's 
  #   a multiple of the required amount but less than or equal to the requested amount. 
  #   If any product remains, the regular price is used.
  def buy(quantity)
    unless self.sale_price.nil? 
      if self.sale_price.quantity_required?
        if quantity >= self.sale_price.for_quantity
          self.sale_price.price_for(self.sale_price.for_quantity * (quantity / self.sale_price.for_quantity)) + self.regular_price.price_for(quantity.modulo(self.sale_price.for_quantity))
        else
          self.regular_price.price_for(quantity)
        end
      else
        self.sale_price.price_for(quantity)
      end
    else
      self.regular_price.price_for(quantity)
    end
  end
end
