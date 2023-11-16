import tkinter as tk
from tkinter import ttk, scrolledtext
import sqlite3

class Database:
    def __init__(self, db_name='data.db'):
        self.connection = self.connect_to_database(db_name)
        self.cursor = self.connection.cursor()

    def connect_to_database(self, db_name):
        try:
            connection = sqlite3.connect(db_name)
            return connection
        except sqlite3.Error as e:
            print(f"An error occurred: {e}")
            return None
        
    def execute_query(self, query):
        try:
            result = self.cursor.execute(query).fetchall()
            column_names = [description[0] for description in self.cursor.description]
            return column_names, result
        except sqlite3.Error as e:
            print(f"An error occurred: {e}")
            return None, None

    def __del__(self):
        if self.connection:
            self.connection.close()

class CoffeeShopGUI:
    def __init__(self, master):
        self.master = master
        master.title("Coffee Shop Management")

        self.text_area = scrolledtext.ScrolledText(master, wrap=tk.WORD, width=40, height=10)
        self.text_area.pack(pady=10)

        self.result_tree = ttk.Treeview(master, columns=('ID', 'Item Name', 'Price', 'Quantity', 'Sale Date'), show='headings')
        self.result_tree.heading('ID', text='ID')
        self.result_tree.heading('Item Name', text='Item Name')
        self.result_tree.heading('Price', text='Price')
        self.result_tree.heading('Quantity', text='Quantity')
        self.result_tree.heading('Sale Date', text='Sale Date')
        self.result_tree.pack(pady=10)

        self.execute_button = tk.Button(master, text="Execute Query", command=self.execute_query)
        self.execute_button.pack()

        self.exit_button = tk.Button(master, text="Exit", command=self.master.quit)
        self.exit_button.pack()

        self.database = Database()


    def display_results(self, column_names, data):
        self.result_tree.delete(*self.result_tree.get_children())

        if not data or not column_names:
            return  # No data to display

        self.result_tree["columns"] = column_names
        self.result_tree.heading("#0", text="Row ID")

        for i, col_name in enumerate(column_names):
            self.result_tree.heading(col_name, text=col_name)
            self.result_tree.column(col_name, anchor=tk.CENTER, width=100)

        for i, row in enumerate(data):
            self.result_tree.insert("", 'end', text=i + 1, values=row)

    def execute_query(self):
        user_input = self.text_area.get("1.0", tk.END).strip()

        if user_input.lower() == 'exit':
            self.master.quit()

        print(f"Executing query: {user_input}")

        try:
            column_names, result = self.database.execute_query(user_input)
            if result is not None:
                self.display_results(column_names, result)
        except sqlite3.Error as e:
            self.result_tree.delete(*self.result_tree.get_children())
            print(f"Error executing query: {e}")

def main():
    root = tk.Tk()
    gui = CoffeeShopGUI(root)
    root.mainloop()

if __name__ == "__main__":
    main()
