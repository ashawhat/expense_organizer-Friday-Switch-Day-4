require 'spec_helper'

describe Purchase do
  describe '#initialize' do
    it 'initializes an instance of Purchase' do
      test_purchase = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase.should be_an_instance_of Purchase
    end

    it 'returns the values of the instance variables' do
      test_purchase = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase.description.should eq 'burgers'
      test_purchase.amount.should eq 5
      test_purchase.date.should eq '2004-10-19 10:23:54'
    end
  end

  describe '#save' do
    it 'saves a purchase to the database' do
      test_purchase = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase.save
      Purchase.all.should eq [test_purchase]
    end
  end

  describe '==' do
    it 'accepts matching names for objects as comparable' do
      test_purchase1 = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase2 = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase1.should eq test_purchase2
    end
  end

  describe '.all' do
    it 'should return all of the objects in database' do
      test_purchase = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase.save
      Purchase.all.should eq [test_purchase]
    end
  end

  describe 'add_category' do
    it 'adds a category to a purchase' do
      test_purchase = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase.save
      test_category = Category.new({'type' => 'restaurants'})
      test_category.save
      test_purchase.add_category(test_category)
      test_result = DB.exec("SELECT * FROM purchase_category WHERE purchase_id = #{test_purchase.id} AND category_id = #{test_category.id}")
      test_result.first['purchase_id'].should eq test_purchase.id.to_s
      test_result.first['category_id'].should eq test_category.id.to_s
    end
  end

  describe '.total_purchases' do
    it 'should give us the total purchases amount' do
      test_purchase1 = Purchase.create({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
      test_purchase2 = Purchase.create({'description' => 'burgers', 'amount' => 20, 'date' => '2004-10-19 10:23:54'})
      test_purchase3 = Purchase.create({'description' => 'burgers', 'amount' => 40, 'date' => '2004-10-19 10:23:54'})
      Purchase.total_purchases.should eq 65
    end
  end

  describe '.total_by_category' do
    it 'will return the total amount for a category' do
      test_purchase1 = Purchase.create({'description' => 'burgers', 'amount' => 5, 'category_id' => 1, 'date' => '2004-10-19 10:23:54'})
      test_purchase2 = Purchase.create({'description' => 'burgers', 'amount' => 20, 'category_id' => 3, 'date' => '2004-10-19 10:23:54'})
      test_purchase3 = Purchase.create({'description' => 'burgers', 'amount' => 40, 'category_id' => 1, 'date' => '2004-10-19 10:23:54'})
      Purchase.total_by_category(3).should eq 20
    end
  end
end
