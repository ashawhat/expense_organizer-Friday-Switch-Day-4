require 'pry'
require 'spec_helper'

describe Category do
  describe '#initialize' do
    it 'initializes an instance of Category' do
      test_category = Category.new({'type' => 'restaurants'})
      test_category.should be_an_instance_of Category
    end

    it 'returns the values of the instance variables' do
      test_category = Category.new({'type' => 'restaurants'})
      test_category.type.should eq 'restaurants'
    end
  end

  describe '#save' do
    it 'saves a category to the database' do
      test_category = Category.new({'type' => 'restaurants'})
      test_category.save
      Category.all.should eq [test_category]
    end
  end

  describe '==' do
    it 'accepts matching types for objects as comparable' do
      test_category1 = Category.new({'type' => 'restaurants'})
      test_category2 = Category.new({'type' => 'restaurants'})
      test_category1.should eq test_category2
    end
  end

  describe '.all' do
    it 'should return all of the objects in database' do
      test_category = Category.new({'type' => 'restaurants'})
      test_category.save
      Category.all.should eq [test_category]
    end
  end




end

 # describe '#expense_percentage' do
  #   it 'will return the percentage of expenses in a category' do
  #     test_purchase1 = Purchase.new({'description' => 'burgers', 'amount' => 5, 'date' => '2004-10-19 10:23:54'})
  #     test_purchase1.save
  #     test_purchase2 = Purchase.new({'description' => 'burgers', 'amount' => 15, 'date' => '2004-10-19 10:23:54'})
  #     test_purchase2.save
  #     test_category1 = Category.new({'type' => 'restaurants'})
  #     test_category1.save
  #     test_category2 = Category.new({'type' => 'hotels'})
  #     test_category2.save
  #     test_purchase1.add_category(test_category1)
  #     test_purchase2.add_category(test_category2)
  #     results = test_category1.expense_percentage
  #     results.should eq 0.25
  #   end
  # end
