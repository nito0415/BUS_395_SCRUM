import os
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

    def get_profit_by_item(self):
        query = """
            SELECT o.item_id,
                   i.item_name,
                   ROUND(SUM(o.quantity), 2) AS total_sold,
                   ROUND(SUM(o.total_price), 2) AS total_revenue,
                   ROUND(SUM(c.total_cost_to_make * o.quantity), 2) AS total_cost,
                   ROUND(SUM(o.total_price - (c.total_cost_to_make * o.quantity)), 2) AS total_profit
            FROM orders o
            JOIN item i ON o.item_id = i.item_id
            JOIN cost_to_make c ON o.item_id = c.item_id
            GROUP BY o.item_id, i.item_name
            ORDER BY (total_profit / total_revenue) DESC
        """
        try:
            result = self.cursor.execute(query).fetchall()
            column_names = [description[0] for description in self.cursor.description]

            # Calculate gross profit percentage and add it to the result
            result_with_percentage = []
            for row in result:
                item_id, item_name, total_sold, total_revenue, total_cost, total_profit = row
                gross_profit_percentage = (total_profit / total_revenue) * 100 if total_revenue != 0 else 0
                result_with_percentage.append((item_id, item_name, round(total_sold, 2), round(total_revenue, 2), round(total_cost, 2), round(total_profit, 2), round(gross_profit_percentage, 2)))

            return column_names + ['Gross Profit Percentage'], result_with_percentage
        except sqlite3.Error as e:
            print(f"An error occurred: {e}")
            return None, None

    def highlight_highest_cost_items(self):
        query = """
            SELECT i.item_id,
                   i.item_name,
                   c.total_cost_to_make
            FROM item i
            JOIN cost_to_make c ON i.item_id = c.item_id
            ORDER BY c.total_cost_to_make DESC
        """
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

        # Add an icon to the window
        icon_path = os.path.abspath("supp_files/plastic-coffee-cup.193x256.png")
        if os.path.exists(icon_path):
            icon = tk.PhotoImage(file=icon_path)
            master.iconphoto(True, icon)
        else:
            print(f"Icon not found at path: {icon_path}")

        self.create_widgets()

        self.database = Database()

    def create_widgets(self):
        # Text area
        self.text_area = scrolledtext.ScrolledText(self.master, wrap=tk.WORD, width=40, height=10)
        self.text_area.pack(fill=tk.BOTH, expand=True, pady=10)

        # Themed buttons
        style = ttk.Style()
        style.configure("TButton", padding=6, relief="flat", background="#ccc")

        # Buttons
        self.execute_button = ttk.Button(self.master, text="Execute Query", command=self.execute_query, style="TButton")
        self.execute_button.pack(pady=5)

        self.profit_button = ttk.Button(self.master, text="Get Profit by Item", command=self.get_profit_by_item, style="TButton")
        self.profit_button.pack(pady=5)

        self.highest_cost_button = ttk.Button(self.master, text="Highlight Highest Cost Items", command=self.highlight_highest_cost_items, style="TButton")
        self.highest_cost_button.pack(pady=5)

        self.exit_button = ttk.Button(self.master, text="Exit", command=self.master.quit, style="TButton")
        self.exit_button.pack(pady=5)

        # Result Tree
        self.result_tree = ttk.Treeview(self.master, columns=('Item ID', 'Item Name', 'Value'), show='headings')
        self.result_tree.heading('Item ID', text='Item ID')
        self.result_tree.heading('Item Name', text='Item Name')
        self.result_tree.heading('Value', text='Value')
        self.result_tree.pack(fill=tk.BOTH, expand=True, pady=10, padx=10)

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

    def get_profit_by_item(self):
        try:
            column_names, result = self.database.get_profit_by_item()
            if result is not None:
                self.display_results(column_names, result)
        except sqlite3.Error as e:
            self.result_tree.delete(*self.result_tree.get_children())
            print(f"Error executing query: {e}")

    def highlight_highest_cost_items(self):
        try:
            column_names, result = self.database.highlight_highest_cost_items()
            if result is not None:
                self.display_results(column_names, result)
        except sqlite3.Error as e:
            self.result_tree.delete(*self.result_tree.get_children())
            print(f"Error executing query: {e}")

def main():
    root = tk.Tk()
    gui = CoffeeShopGUI(root)
    
    # Set a fixed size for the window
    root.geometry("800x600")
    
    root.mainloop()

if __name__ == "__main__":
    main()
