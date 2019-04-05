
class AppRevsCli::CLI

  def call
    header
    menu
  end

  def header
    puts " ____________________________"
    puts "|          AppRevs           |"
    puts "|                            |"
    puts "|  ** Latest App Reviews **  |"
    puts "|                            |"
    puts "|____________________________|"
    puts "\n"
  end

  def menu
    get_category_details
    selection_prompt
    app_reviews
    view_more_apps
  end

  def get_category_details
    @category_size = AppRevsCli::Category.all.size
    puts @category_size

    if @category_size == 0
      AppRevsCli::Scraper.new.scrape_categories
      AppRevsCli::Category.list_categories
      @category_size = AppRevsCli::Category.all.size
    else
      AppRevsCli::Category.list_categories
      @category_size = AppRevsCli::Category.all.size
    end
  end

  def selection_prompt
    puts "\n"
    puts "What type of software are you interested in? (select options [1] to [#{@category_size}])"
    user_input
  end

  def user_input
    @input = gets.strip.to_i

    case @input
    when 1..@category_size
        @input
      else
        puts "Invalid selection choose a number that corresponds with the app category listed above. Your options are [1] to [#{@category_size}] "
        user_input
    end

  end

#app_outputs
def app_reviews
  @app_size = AppRevsCli::App.all.size

  if @app_size == 0
    @category_object = AppRevsCli::Category.find_category_by_index(@input)
    AppRevsCli::Scraper.new.scrape_apps(@category_object)
    show_app_list
  else
    AppRevsCli::App.destroy_all
    @category_object = AppRevsCli::Category.find_category_by_index(@input)
    AppRevsCli::Scraper.new.scrape_apps(@category_object)
    show_app_list
  end
end


def show_app_list
  if AppRevsCli::App.all.size > 5
    list_apps_top_five
  else
    list_apps_with_detail
  end
end

def list_apps
  AppRevsCli::App.all.each.with_index(1) do |app, index|
    puts "#{index}) #{app.name}"
  end
end

def list_apps_with_detail
  AppRevsCli::App.all.each.with_index(1) do |app, index|
    puts "\n"
    puts "#{index}) #{app.name}"
    puts "Category: #{app.category.chomp("Software")}"
    puts "Reviews #{app.total_reviews}"
    puts "Review: #{app.review}"
  end
end

def list_apps_top_five
  first_five = AppRevsCli::App.all.first(5)
  first_five.each.with_index(1) do |app, index|
    puts "\n"
    puts "#{index}) #{app.name}"
    puts "Category: #{app.category.chomp("Software")}"
    puts "Reviews: #{app.total_reviews}"
    puts "Summary: #{app.review}\n"
  end
end

def list_remaining_apps
  remaining_apps = AppRevsCli::App.all[5..-1]
  remaining_apps.each.with_index(1) do |app, index|
    puts "\n#{index+5}) #{app.name}"
    puts "Category: #{app.category.chomp("Software")}"
    puts "Reviews #{app.total_reviews}"
    puts "Review: #{app.review}\n"
    puts "\n"
  end
end


#Utility_methods
def return_to_menu
  puts "\nWould you like to return to the menu? [Y/n]"
  input = gets.strip.downcase

  if input == "y"
    menu
  elsif input == "n"
    exit_message
  else
    puts "\nInvalid input please enter 'y' or 'n'"
    return_to_menu
  end
end



def exit_message
  puts "\nThanks for using AppRevs"
end

  def view_more_apps
    puts "\nview remaining #{AppRevsCli::App.all.size-6} apps? [Y/n]"
    input = gets.strip.downcase

    if input == "y"
      list_remaining_apps
      return_to_menu
    elsif input == "n"
      exit_message
    else
      puts "Invalid input please enter 'y' or 'n'"
      view_more_apps
    end
  end


end
