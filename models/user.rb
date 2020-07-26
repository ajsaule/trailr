require 'bcrypt'

def run_sql query, arr = []
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'trails_app'})
    results = db.exec_params query, arr
    db.close 
    results
end 

def find_all_users
    run_sql "SELECT * FROM users;"
end 

def find_user_by_id id 
    sql = "SELECT * FROM users where id = $1;"
    users = run_sql sql, [id] 
    users.first
end 

def find_one_user_by_email email
    sql = "SELECT * FROM users WHERE email = $1;"
    users = run_sql sql, [email]
    users.first
end

def find_one_user_by_username username
    sql = "SELECT * FROM users WHERE username = $1;"
    users = run_sql sql, [username]
    users.first
end

# account creation is broken. 
def create_user username, email, password
    password_digest = BCrypt::Password.create(password)
    sql = "INSERT INTO users (username, email, password_digest) VALUES ($1, $2, $3);"
    run_sql sql, [username, email, "#{password_digest}"]
end 

def destroy_user id 
    sql = "DELETE from USERS WHERE id = $1;"
    run_sql sql, [id]
end 