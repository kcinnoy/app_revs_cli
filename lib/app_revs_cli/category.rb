class AppRevsCli::Category

  attr_accessor :name, :url

  @@all = []

  def save
    @@all << self
  end

  #class methods
  def self.all
    @@all
  end

  def self.find_category_by_index(index)
    @@all[index-1]
  end

  def self.list_categories
    @@all.each.with_index(1) do |category, index|
      puts "#{index}) #{category.name}"
    end
  end

end
