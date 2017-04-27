class App::Recipe < ActiveRecord::Base
  def get
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: 'hunk_development',
      url: 'postgres://localhost/hunk_development'
    )

    sql = "SELECT name from recipes limit 50;"

    @recipes = ActiveRecord::Base.connection.select_all(sql)
    puts @recipes.inspect
  end
end
