require 'spec_helper'
require 'logger'

describe Price do
  before :all do
    @logger = Logger.new STDOUT
  end

  describe "with simple pricing" do
    before :each do
      @p = Price.new(@logger, 100)
    end

    (0..2).each do |i|
      it "will return proper price for #{i} item" do
        expect(@p.price_in_cents).to eq(100)
        expect(@p.for_quantity).to eq(1)
        expect(@p.quantity_required?).to eq(false)
        expect(@p.price_for(i)).to eq(i * 100)
      end
    end
  end

  describe "with more complex pricing" do
    before :each do
      @p = Price.new(@logger, 100, 3)
    end

    it "will return proper price for 3 items" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(3)
      expect(@p.quantity_required?).to eq(false)
      expect(@p.price_for(3)).to eq(100)
    end

    it "will return proper price for 2 items" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(3)
      expect(@p.quantity_required?).to eq(false)
      expect(@p.price_for(2)).to eq(67)
    end

    it "will return proper price for 1 item" do
      expect(@p.price_in_cents).to eq(100)
      expect(@p.for_quantity).to eq(3)
      expect(@p.quantity_required?).to eq(false)
      expect(@p.price_for(1)).to eq(34)
    end
  end

  describe "sale prices with freebies" do
    it "prices correctly when exact amount is bought" do
      p = Price.new(@logger, 100, 2, 1)
      expect(p.quantity_required?).to eq(true)
      expect(p.price_for(3)).to eq(200)
    end

    it "throws an exception when too many are bought" do
      p = Price.new(@logger, 100, 2, 1)
      expect(p.quantity_required?).to eq(true)
      lambda{p.price_for(4)}.should raise_error(/Invalid quantity supplied/)
    end

    it "throws an exception when too few are bought" do
      p = Price.new(@logger, 100, 2, 1)
      expect(p.quantity_required?).to eq(true)
      lambda{p.price_for(1)}.should raise_error(/Invalid quantity supplied/)
    end
  end
end
