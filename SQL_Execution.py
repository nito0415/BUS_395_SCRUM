import sqlite3

# Connect to the SQLite database (create one if it doesn't exist)
with sqlite3.connect('data.db') as conn:
    # Create a cursor object to execute SQL queries
    cursor = conn.cursor()

    # Read the SQL file
    with open('SCRUM Project Sprint 1 Creating Tables (1).sql', 'r') as sql_file:
        sql_queries = sql_file.read()

    # Execute the SQL statements
    try:
        cursor.executescript(sql_queries)
    except sqlite3.Error as e:
        print(f"An error occurred: {e}")
    else:
        # Commit the changes
        conn.commit()
