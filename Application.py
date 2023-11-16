import sqlite3

def connect_to_database(db):
    return sqlite3.connect(db)

def execute_query(connection, query):
    cursor = connection.cursor()
    cursor.execute(query)
    return cursor.fetchall()

def print_report(data):
    for row in data:
        print(row)

def main():
    data = 'data.db'
    connection = connect_to_database(data)

    while True:
        user_input = input("Enter SQL query (or 'exit' to quit): ")

        if user_input.lower() == 'exit':
            break

        try:
            result = execute_query(connection, user_input)
            print_report(result)
        except sqlite3.Error as e:
            print(f"Error executing query: {e}")

    connection.close()

if __name__ == "__main__":
    main()