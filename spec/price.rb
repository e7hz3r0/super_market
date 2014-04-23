require 'spec_helper'

describe Price do
  describe "with simple pricing" do
    before :each do
      @p = Price.new(100)
    end

    it "will return proper price for 1 item" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(1)
      expect(@p.is_quantity_required).to eq(false)
      expect(@p.price_for(1)).to eq(100)
    end

    it "will return proper price for 2 items" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(1)
      expect(@p.is_quantity_required).to eq(false)
      expect(@p.price_for(2)).to eq(200)
    end
  end

  describe "with more complex pricing" do
    before :each do
      @p = Price.new(100, 3)
    end

    it "will return proper price for 3 items" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(3)
      expect(@p.is_quantity_required).to eq(false)
      expect(@p.price_for(3)).to eq(100)
    end

    it "will return proper price for 2 items" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(3)
      expect(@p.is_quantity_required).to eq(false)
      expect(@p.price_for(2)).to eq(67)
    end

    it "will return proper price for 1 item" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(3)
      expect(@p.is_quantity_required).to eq(false)
      expect(@p.price_for(1)).to eq(34)
    end
  end
end
