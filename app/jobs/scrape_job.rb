require 'nokogiri'
require 'open-uri'

class ScrapeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    url = 'https://www.imdb.com/chart/top'

    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    movies = doc.css('.lister-list tr').take(20)
    movies.each_with_index do |movie, index|
      movie_url = "https://www.imdb.com#{movie.css('.titleColumn a').first['href']}"
      user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
    
      response_for_description = URI.open(movie_url, "User-Agent" => user_agent)
      doc_for_description = Nokogiri::HTML(response_for_description)

      title = movie.css('.titleColumn a').text.strip
      description = doc_for_description.css('.ipc-html-content.ipc-html-content--base').text.strip
      rating = movie.css('.imdbRating strong').text.strip
      year = movie.css('.titleColumn span').text.strip.gsub(/[()]/, '')
      genre = movie.css('.genre').text.strip
      director = movie.css('.titleColumn a').attribute('title').value.split(",").first.split("(")[0]
      stars = movie.css('.titleColumn a').attribute('title').value.split(",")

      add_genre = Genre.find_or_create_by!(name: genre) 
      add_movie = Movie.find_or_create_by!(title: title, release_year: year.to_i, genre_id: add_genre.id, description: description )
      add_rating = Rating.find_or_create_by!(value: rating.to_f, movie_id: add_movie.id, user_id: 4)

    end
  end
end