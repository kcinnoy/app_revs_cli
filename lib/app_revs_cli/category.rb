class AppRevsCli::Category

  attr_accessor :name, :url

  @@all = []

  # def self.find_category_url(category_index)
  #   find_category_by_index(category_index).url
  # end

  def save
    @@all << self
  end

  def add_app(app)
    app.category = self unless app.category
    @apps << app unless @apps.include?(app)
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
