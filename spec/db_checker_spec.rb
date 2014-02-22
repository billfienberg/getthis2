require 'rubygems'
require 'rspec'
require 'pry'

require_relative '../lib/db_checker.rb'

describe ItemChecker do 

  let(:item) { ItemChecker.new }

  it "exists" do
    expect(ItemChecker).to be_a(Class)
  end

  describe "#exists?" do
    xit "checks to see if item exists" do
      have_item = item.exists?
    end
  end


end