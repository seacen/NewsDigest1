require_relative 'news.rb'
require_relative 'tgjson_importer.rb'
require_relative 'hsrss_importer.rb'
require_relative 'tarss_importer.rb'
require_relative 'csv_formatter.rb'

scraper = News::Scraper.new

# Register the source and importer/formatter
scraper.register_source HsRssImporter.source_name, HsRssImporter, CsvFormatter
scraper.register_source TaRssImporter.source_name, TaRssImporter, CsvFormatter
scraper.register_source TgJsonImporter.source_name, TgJsonImporter, CsvFormatter

# Run the scrape
scraper.scrape
