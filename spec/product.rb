require 'spec_helper'

describe Product do
  before :all do
    @logger = Logger.new STDOUT
  end

  before :each do
    @reg_cents = 200
    @np = Price.new(@logger, @reg_cents, 1)
    @p = Product.new(@logger, @np)
  end

  it "will show 0 when none are purchased" do
    expect(@p.buy(0)).to  eq(0)
  end

  it "will show it's normal price with no sale" do
    expect(@p.buy(1)).to  eq(@reg_cents)
  end

  it "will show it's normal price, multiplied correctly when multiple are bought with no sale" do
    expect(@p.buy(3)).to  eq(3 * @reg_cents)
  end

  it "will show sale price when item is sale-priced simply" do
    @p.sale_price = Price.new(@logger, 50, 1)
    expect(@p.buy(1)).to eq(50)
  end

  it "will show sale price when item is sale-priced more complexly" do
    @p.sale_price = Price.new(@logger, 100, 3)
    expect(@p.buy(1)).to eq(34)
  end

  it "will show sale price when item is sale-priced strictly" do
    @p.sale_price = Price.new(@logger, 100, 3, 0, true)
    expect(@p.buy(3)).to eq(100)
  end

  it "will show regular price when item is sale-priced strictly and not enough is purchased" do
    @p.sale_price = Price.new(@logger, 100, 3, 0, true)
    expect(@p.buy(1)).to eq(@reg_cents)
  end

  it "will show combination of regular and sale price when item is sale-priced strictly and more than enough is purchased" do
    @p.sale_price = Price.new(@logger, 100, 3, 0, true)
    expect(@p.buy(4)).to eq(100 + @reg_cents)
  end

  describe "with freebies" do
    it "will show regular price with too few purchased" do
      @p.sale_price = Price.new(@logger, 100, 2, 1) #buy 2, get 1 free
      expect(@p.buy(2)).to eq(2 * @reg_cents)
    end

    it "will show sale price with exact quantity" do
      @p.sale_price = Price.new(@logger, 100, 2, 1) #buy 2, get 1 free
      expect(@p.buy(3)).to eq(200)
    end

    it "will show sale price with exact multiple of quantity" do
      @p.sale_price = Price.new(@logger, 100, 2, 1) #buy 2, get 1 free
      expect(@p.buy(6)).to eq(400)
    end

    it "will show sale price for sale quantity and regular price for the rest" do
      @p.sale_price = Price.new(@logger, 100, 2, 1) #buy 2, get 1 free
      expect(@p.buy(4)).to eq(400)
    end
  end
 
end
