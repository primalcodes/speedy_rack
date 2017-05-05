require 'json'

class App::SimpleController < App

  get '/' do
    sql = "SELECT title from recipes limit 50;"
    @recipes = ActiveRecord::Base.connection.select_all(sql)

    render 'index.html.erb'
  end
  alias_endpoint '/index', '/'

  get '/payload' do
    sql = "SELECT payload from document_payloads limit 1;"
    record = ActiveRecord::Base.connection.select_one(sql)
    @payload = JSON.parse(record["payload"])["recipe"]
    puts @payload["recipe"]
    # JSON.dump(@payload["recipe"])
    render 'payload.html.erb'
  end

  get '/recipe' do
    sql = "SELECT payload from document_payloads where id=3;"
    record = ActiveRecord::Base.connection.select_one(sql)
    @payload = JSON.parse(record["payload"])["recipe"]
    puts @payload["recipe"]
    # JSON.dump(@payload["recipe"])
    render 'payload.html.erb'
  end

  get '/recipes/:id' do
    # where_clause = "meta @> {'document_id': #{params[:id].to_i}, \"'document_type': 'recipe', 'context': 'document'}\""
    sql = "SELECT payload from document_payloads where meta @> '{\"document_id\": #{params['id'].to_i}, \"document_type\": \"recipe\", \"context\": \"document\"}'\;"
    puts sql
    record = ActiveRecord::Base.connection.select_one(sql)
    @payload = JSON.parse(record["payload"])["recipe"]
    puts @payload["recipe"]
    # JSON.dump(@payload["recipe"])
    render 'payload.html.erb'
  end
end
