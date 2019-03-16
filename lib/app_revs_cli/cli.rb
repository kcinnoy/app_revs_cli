
class AppRevsCli::CLI

  def call
    header
    menu
    app_reviews
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
    user_input
  end

  def get_category_details
    AppRevsCli::Scraper.new.scrape_categories
    AppRevsCli::Category.list_categories
    @category_size = AppRevsCli::Category.all.size
  end

  def selection_prompt
    puts "\n"
    puts "What type of software are you interested in? (select options [1] to [#{@category_size}])"
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
    @category_object = AppRevsCli::Category.find_category_by_index(@input)
    AppRevsCli::Scraper.new.scrape_apps(@category_object)
    AppRevsCli::App.show_app_list
  end

end
