require 'erubis'
require 'active_record'
# require './config/environments'

class App < Rack::App
  apply_extensions :front_end
  layout 'layout.html.erb'
  mount App::SimpleController

  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    database: 'hunk_development',
    url: 'postgres://localhost/hunk_development',
    pool: 16,
    reaping_frequency: 10
  )

  serve_files_from '/www'


end
