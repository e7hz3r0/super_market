require 'spec_helper'

describe Product do
  before :each do
    @np = Price.new(100, 1)
    @p = Product.new(@np)
  end

  it "will show it's normal price with no sale" do
    expect(@p.buy(1)).to  eq(100)
  end

  it "will show it's normal price, multiplied correctly when multiple are bought with no sale" do
    expect(@p.buy(3)).to  eq(300)
  end

  it "will show sale price when item is sale-priced simply" do
    @p.sale_price = Price.new(50, 1)
    expect(@p.buy(1)).to eq(50)
  end

  it "will show sale price when item is sale-priced more complexly" do
    @p.sale_price = Price.new(100, 3)
    expect(@p.buy(1)).to eq(34)
  end

  it "will show sale price when item is sale-priced strictly" do
    @p.sale_price = Price.new(100, 3, true)
    expect(@p.buy(3)).to eq(100)
  end

  it "will show regular price when item is sale-priced strictly and not enough is purchased" do
    @p.sale_price = Price.new(100, 3, true)
    expect(@p.buy(1)).to eq(100)
  end

  it "will show combination of regular and sale price when item is sale-priced strictly and more than enough is purchased" do
    @p.sale_price = Price.new(100, 3, true)
    expect(@p.buy(4)).to eq(200)
  end
 
end
