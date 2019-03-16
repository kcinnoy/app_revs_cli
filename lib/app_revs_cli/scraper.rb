class AppRevsCli::Scraper

  def scrape_categories
    site = "https://www.getapp.com"
    @doc = Nokogiri::HTML(open(site))
    category_section = @doc.search("a.popular-categories-card")
    category_links = category_section
    category_links.each do |link|
      category = AppRevsCli::Category.new

      category.name = link.css("p.popular-categories-link").text
      category.url = "#{site}#{link.attr("href")}"

      category.save
    end
  end

  def scrape_apps(category_object)
    site = category_object.url
    @doc = Nokogiri::HTML(open(site))
    list_section = @doc.search("div.listing")
    list_section.each do |app_item|
      app = AppRevsCli::App.new
      app.name = app_item.search("h2.listing-title").text.split(" ")[0].strip.gsub(/Software/, "")
      app.review = app_item.search("span.listing-overview").text
      app.total_reviews = app_item.search("a.rating-stars span").text.split(" ")[0]
      app.category = category_object.name

      app.save
    end
  end

end
