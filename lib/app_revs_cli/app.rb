class AppRevsCli::App
  attr_accessor :name, :total_reviews, :review, :rating, :category

  @@all = []

  def save
    @@all << self
  end

  #class methods
  def self.all
    puts @@all
  end

  def self.list_apps
    @@all.each.with_index(1) do |app, index|
      puts "#{index}) #{app.name}"
    end
  end

  def self.list_apps_with_detail
    @@all.each.with_index(1) do |app, index|
      puts "\n"
      puts "#{index}) #{app.name}"
      puts "Category: #{app.category}"
      puts "Reviews (#{app.total_reviews})"
      puts "Review: (#{app.review})"
    end
  end

  def self.list_apps_with_detail
  end

end
