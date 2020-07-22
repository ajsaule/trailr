def run_sql query
    db = PG.connect(dbname: 'trails_app')
    results = db.exec(query)
    db.close 
    results
end 

def find_all_trails
    run_sql "SELECT * FROM trails" # do a join table to get the Nickname data from users
end 

def find_one_trail_by_id id 
    one_trail = run_sql "SELECT * FROM trails WHERE id = #{id}" #test to see if this returns the first item 
    result = one_trail.first
end 

def create_trail title, image_url, description, rating, difficulty
    run_sql "INSERT INTO trails (title, image_url, description, rating, difficulty) VALUES ('#{title}', '#{image_url}', '#{description}', #{rating}, '#{difficulty}');"
end 

def destroy_trail id 
    run_sql "DELETE FROM dishes WHERE id = #{id}"
end 

def update_trail title, image_url, description, rating, difficulty
    run_sql "UPDATE trails SET title = '#{title}', image_url = '#{img_url}', description = '#{description}', rating = #{rating}, difficulty = '#{difficulty}';"
end 