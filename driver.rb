require_relative 'news.rb'
require_relative 'tgjson_importer.rb'
require_relative 'hsrss_importer.rb'
require_relative 'tarss_importer.rb'
require_relative 'csv_formatter.rb'
require_relative 'json_formatter.rb'

scraper = News::Scraper.new

# Register the source and importer/formatter
# scraper.register_source :HsRssCsv, HsRssImporter, CsvFormatter
# scraper.register_source :TaRssCsv, TaRssImporter, CsvFormatter
# scraper.register_source :TgJsonCsv, TgJsonImporter, CsvFormatter
#
# scraper.register_source :TgJsonJson, TgJsonImporter, JsonFormatter
# scraper.register_source :HsRssJson, HsRssImporter, JsonFormatter
# scraper.register_source :TaRssJson, TaRssImporter, JsonFormatter

# Run the scrape
scraper.scrape
