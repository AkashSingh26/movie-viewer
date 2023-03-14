namespace :scrap do
    desc "Enqueue ScrapJob"
    task :enqueue => :environment do
      ScrapeJob.perform_later
    end
end