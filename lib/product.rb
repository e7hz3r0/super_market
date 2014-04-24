require 'logger'

class Product
  include ActiveModel::Model
  attr_accessor :regular_price, :sale_price

  # Constructor - takes a Price object describing this product's regular price
  def initialize(logger, regular_price)
    @logger = logger
    self.regular_price = regular_price

    @logger.info "Product created with regular price of #{regular_price.description}"
  end

  # Purchase the given quantity of this product
  # Returns the total cost
  # If the price requires the exact quantity to get the price (3 for $1.00, must buy 3):
  # - If you buy less than the required amount, the regular price is used
  # - If you buy more, then the sale price is used for the maximum number of items that's 
  #   a multiple of the required amount but less than or equal to the requested amount. 
  #   If any product remains, the regular price is used.
  # If the price is for some quantity N, where you then get M items free, the logic is (usually the sale price and regular price will be the same here - the sale just gives you M items free):
  # - If you buy N+M (or a multiple of it), N+M items are priced at the sale price and then the cost of M items is removed
  # - If you buy less the N+M, then all items are priced at the regular price, but no item's cost is removed
  # - If you buy more than N+M, the largest multiple of N+M is treated as above, and all remaining items that don't add to N+M are priced at the regular price
  def buy(quantity)
    msg = "Attempting to purchase #{quantity} items of product with regular price of '#{self.regular_price.description}.'"
    msg += " On sale for #{self.sale_price.description}." if on_sale?
    @logger.info msg

    if on_sale?
      @logger.info "Product is on-sale."

      if self.sale_price.quantity_required?
        total_required_for_sale = self.sale_price.for_quantity + self.sale_price.quantity_for_free

        @logger.info "Sale price requires the purchase of at least #{total_required_for_sale} items."

        if quantity >= total_required_for_sale
          sale_quantity = total_required_for_sale * (quantity / total_required_for_sale)
          reg_quantity = quantity.modulo(total_required_for_sale)

          @logger.info "#{sale_quantity} will be priced at sale price. #{reg_quantity} will be priced at regular price."

          cost =self.sale_price.price_for(sale_quantity) + self.regular_price.price_for(reg_quantity)
        else
          @logger.info "Not enough items are being purchased to qualify for sale pricing, using regular price."
          cost =self.regular_price.price_for(quantity)
        end
      else
        @logger.info "Sale price is per-item."

        cost =self.sale_price.price_for(quantity)
      end
    else
      @logger.info "Product not on-sale. Using regular price."
      cost =self.regular_price.price_for(quantity)
    end

    @logger.info "Total cost for purchase of #{quantity} items is #{cost} cents."
    cost
  end

  def on_sale?
    !self.sale_price.nil?
  end
end
