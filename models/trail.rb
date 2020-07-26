def run_sql query, arr = []
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'trails_app'})
    results = db.exec_params query, arr 
    db.close 
    results
end 

def find_all_trails
    run_sql "SELECT * FROM trails" # do a join table to get the Nickname data from users
end 

def find_one_trail_by_id id 
    one_trail = run_sql "SELECT * FROM trails WHERE id = $1;", [id] #test to see if this returns the first item 
    result = one_trail.first
end 

def create_trail title, image_url, description, rating, difficulty, user_id
    sql = "INSERT INTO trails (title, image_url, description, rating, difficulty, user_id) VALUES ($1, $2, $3, $4, $5, $6);"
    run_sql sql, [title, image_url, description, rating, difficulty, user_id]
end 

def destroy_trail id 
    sql = "DELETE FROM trails WHERE id = $1"
    run_sql sql, [id]
end 

def update_trail title, image_url, description, rating, difficulty, id 
    sql = "UPDATE trails SET title = $1, image_url = $2, description = $3, rating = $4, difficulty = $5 WHERE id = $6;"
    run_sql sql, [title, image_url, description, rating, difficulty, id]
end 

def search_trail title 
    sql = "SELECT * FROM trails WHERE title ILIKE $1;"
    run_sql sql, [title]
end