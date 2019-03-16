
class AppRevsCli::CLI

  def coll
    puts " comment goes here"
  end

  def call
    header
    # AppRevsCli::Scraper.new.scrape_categories
    # menu
    # list_categories
  end

  def header
    puts " ____________________________"
    puts "|         AppRevs            |"
    puts "|                            |"
    puts "|    Latest App Reviews      |"
    puts "|                            |"
    puts "|____________________________|"
  end


  def menu
    selection_prompt
    user_input
  end

  # category_size = AppRevsCli::Category.all.size
  # category_url = AppRevsCli::Category.category_url
  # AppRevsCli::Category.all

  def selection_prompt
    puts "\n What type of software are you interested in? (select options [1] to [#{category_size}])"
  end
  #
  #
  # def user_input
  #   input = ""
  #
  #   case input
  #     when between.(1,category_size)
  #       AppRevsCli::App.scrape_apps(category_url)
  #     else
  #       puts "Invalid selection choose a number that corresponds with the app category listed above. Your options are [1] to #{category_size}"
  #   end
  #   user_input
  # end
  #


end
