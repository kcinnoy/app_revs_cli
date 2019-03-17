
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
  end

  def get_category_details
    @category_size = AppRevsCli::Category.all.size

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

  def app_reviews
    @app_size = AppRevsCli::App.all.size
    puts @app_size

    if @app_size == 0
      @category_object = AppRevsCli::Category.find_category_by_index(@input)
      AppRevsCli::Scraper.new.scrape_apps(@category_object)
      AppRevsCli::App.show_app_list
      return_to_menu
    else
      AppRevsCli::App.destroy_all
      @category_object = AppRevsCli::Category.find_category_by_index(@input)
      AppRevsCli::Scraper.new.scrape_apps(@category_object)
      AppRevsCli::App.show_app_list
      return_to_menu
    end
  end

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

end
