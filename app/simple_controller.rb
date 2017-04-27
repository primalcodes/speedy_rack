require 'json'

class App::SimpleController < App

  get '/' do
    sql = "SELECT title from recipes limit 50;"

    @recipes = ActiveRecord::Base.connection.select_all(sql)
    puts @recipes.inspect

    render 'index.html.erb'
  end
  alias_endpoint '/index', '/'

  get '/test' do
    JSON.dump({"type" => "something"})
  end

end
