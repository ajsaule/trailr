require 'bcrypt'

def run_sql query
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'trails_app'})
    results = db.exec(query)
    db.close 
    results
end 

def find_all_users
    run_sql "SELECT * FROM users;"
end 

def find_user_by_id id 
    users = run_sql "SELECT * FROM users where id = #{id};" 
    users.first
end 

def find_one_user_by_email email
    users = run_sql "SELECT * FROM users WHERE email = '#{email}';"
    users.first
end

def find_one_user_by_username username
    users = run_sql "SELECT * FROM users WHERE username = '#{username}';"
    users.first
end

def create_user username, email, password
    password_digest = BCrypt::Password.create(password)
    run_sql "INSERT INTO users (username, email, password_digest) VALUES ('#{username}', '#{email}', '#{password_digest}');"
end 

def destroy_user id 
    sql = "DELETE from USERS WHERE id = #{id};"
    run_sql sql
end 