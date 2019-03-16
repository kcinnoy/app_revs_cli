class AppRevsCli::App
  attr_accessor :name, :total_reviews, :review, :category

  @@all = []

  def save
    @@all << self
  end

  #class methods
  def self.all
    puts @@all
  end

  def self.show_app_list
    if @@all.size > 5
      list_apps_top_five
    else
      list_apps_with_detail
    end
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
      puts "Reviews #{app.total_reviews}"
      puts "Review: #{app.review}"
    end
  end

  def self.list_apps_top_five
    first_five = @@all.first(5)
    first_five.each.with_index(1) do |app, index|
      puts "\n"
      puts "#{index}) #{app.name}"
      puts "Category: #{app.category}"
      puts "Reviews #{app.total_reviews}"
      puts "Review: #{app.review}\n"
    end
    view_more_apps
  end

  def self.view_more_apps
    puts "\n"
    list_apps
    puts "\n"
    puts "view remaining #{@@all.size-5} apps? [Y/n]"
    input = gets.strip.downcase

    if input == "y"
      list_remaining_apps
    elsif input == "n"
      exit_message
    else
      puts "Invalid input please enter 'y' or 'n'"
    end
    view_more_apps
  end

  def self.list_remaining_apps
    remaining_apps = @@all[5..-1]
    remaining_apps.each.with_index(1) do |app, index|
      puts "\n"
      puts "#{index+5}) #{app.name}"
      puts "Category: #{app.category}"
      puts "Reviews #{app.total_reviews}"
      puts "Review: #{app.review}\n"
      puts "\n"
    end
    return_to_menu
  end

  def self.exit_message
    puts "Thanks for using AppRevs"
  end

  def self.return_to_menu
    input = gets.strip.downcase

    if input == "y"
      menu
    elsif input2 == "n"
      exit_message
    else
      puts "Invalid input please enter 'y' or 'n'"
      return_to_menu
    end
  end

end
