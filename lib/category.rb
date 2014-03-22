require "pry"

class Category

  attr_reader :type, :id

  def initialize(input_hash)
    @type = input_hash['type']
    @id = input_hash['id']
  end

  def self.create(input_hash)
    new_category = Category.new(input_hash)
    new_category.save
    new_category
  end

  def save
    result = DB.exec("INSERT INTO category (type) VALUES ('#{@type}') RETURNING id;")
    @id = result.first['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM category;")
    categories = []
    results.each do |result|
      categories << Category.new(result)
    end
    categories
  end

  def ==(another_category)
    self.type == another_category.type
  end






end

  # def expense_percentage
  #   total_all = 0
  #   total_cat = 0
  #   purchase_array = []
  #   purchase_ids = []
  #   purchases = []

  #   all_purchases = DB.exec("SELECT * FROM purchase;")
  #   all_purchases.each do |result|
  #     total_all += result['amount'].to_i
  #   end
  #   purchase_array << DB.exec("SELECT * FROM purchase_category WHERE category_id = #{self.id};")
  #   purchase_array.each do |result|
  #     purchase_ids << result['purchase_id'].to_i
  #   end
  #   purchase_ids.each do |purchase_id|
  #     purchases << DB.exec("SELECT * FROM purchase WHERE id = #{purchase_id};")
  #   end
  #   purchases.each do |purchase|
  #     total_cat += purchase['amount'].to_i
  #   end
  # percent = total_cat/total_all
  # end



