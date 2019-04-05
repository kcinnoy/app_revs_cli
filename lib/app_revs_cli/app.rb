class AppRevsCli::App
  attr_accessor :name, :total_reviews, :review, :category

  @@all = []

  def save
    @@all << self
  end

  #class methods
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
    return "\n"
  end

end
