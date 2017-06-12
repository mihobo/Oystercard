require "oystercard.rb"

describe Oystercard do
it "has a balance" do
  # oystercard = Oystercard.new
  expect(subject.balance).to eq nil
end

it "will top up balance" do
subject.top_up(17)
expect(subject.balance).to eq 17


end
end
