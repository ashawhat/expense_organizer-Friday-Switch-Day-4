# require "pry"


class Purchase

  attr_reader :description, :amount, :date, :id, :category_id

  def initialize(input_hash)
    @description = input_hash['description']
    @amount = input_hash['amount']
    @date = input_hash['date']
    @id = input_hash['id'].to_i
    @category_id = input_hash['category_id'].to_i
  end

  def self.create(input_hash)
    new_purchase = Purchase.new(input_hash)
    new_purchase.save
    new_purchase
  end

  def save
    result = DB.exec("INSERT INTO purchase (description, amount, date, category_id) VALUES ('#{@description}', #{@amount}, '#{@date}', #{@category_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM purchase;")
    purchases = []
    results.each do |result|
      purchases << Purchase.new(result)
    end
    purchases
  end

  def ==(another_purchase)
    self.description == another_purchase.description && self.date == another_purchase.date
  end

  def add_category(category)
    result = DB.exec("INSERT INTO purchase_category (purchase_id, category_id) VALUES (#{@id}, #{category.id});")
  end

  def self.total_purchases
    result = DB.exec("SELECT sum(amount) FROM purchase;")
    p result.first
    result.first['sum'].to_i
  end

  def self.total_by_category(cat_id)
    result = DB.exec("SELECT sum(amount) FROM purchase WHERE category_id = #{cat_id};")
    result.first['sum'].to_i
  end
end


# require 'pg'
# DB = PG.connect({:dbname => 'expense_organizer_test'})

# p test_purchase1 = Purchase.create({'description' => 'burgers', 'amount' => 5, 'category_id' => 1, 'date' => '2004-10-19 10:23:54'})

# DB.exec("SELECT sum(amount) FROM purchase WHERE category_id =;")

