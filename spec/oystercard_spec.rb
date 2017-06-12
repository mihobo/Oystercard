require "oystercard.rb"

describe Oystercard do

let (:oystercard) {Oystercard.new}

describe "#balance" do
    it "has a balance" do
    expect(oystercard.balance).to eq 0
    end

    it "will top up balance" do
    oystercard.top_up(17)
    expect(oystercard.balance).to eq 17
    end
end

describe "#top_up" do
    it "will raise an error if new balance exceeds £90 limit" do
    expect{oystercard.top_up(91)}.to raise_error("Balance £91, Limit exceeded")
  end
end

end
