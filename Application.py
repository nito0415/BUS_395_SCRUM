# Import necessary libraries
import os
import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import sqlite3
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg


# Database class for managing SQLite database operations
class Database:
    """
    A class representing a database connection and operations.

    Attributes:
        connection (sqlite3.Connection): The connection to the SQLite database.
        cursor (sqlite3.Cursor): The cursor for executing SQL queries.

    Methods:
        __init__(self, db_name='data.db'): Initializes the database connection and cursor.
        connect_to_database(self, db_name): Connects to the SQLite database.
        execute_query(self, query): Executes a query and fetches the results.
        get_profit_by_item(self): Retrieves profit information by item.
        highlight_highest_cost_items(self): Retrieves items with the highest cost to make.
        __del__(self): Closes the database connection when the object is deleted.
    """
    def __init__(self, db_name='data.db'):
        # Initialize the database connection and cursor
        self.connection = self.connect_to_database(db_name)
        self.cursor = self.connection.cursor()

    def connect_to_database(self, db_name):
        try:
            # Attempt to connect to the SQLite database
            connection = sqlite3.connect(db_name)
            return connection
        except sqlite3.Error as e:
            # Print an error message if connection fails
            print(f"An error occurred: {e}")
            return None

    def execute_query(self, query):
        try:
            # Execute a query and fetch the results
            result = self.cursor.execute(query).fetchall()
            column_names = [description[0] for description in self.cursor.description]
            return column_names, result
        except sqlite3.Error as e:
            # Print an error message if query execution fails
            print(f"An error occurred: {e}")
            return None, None

    def get_profit_by_item(self):
        # SQL query to retrieve profit information by item
        query = """
            SELECT o.item_id,
                   i.item_name,
                   o.date_sold, 
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
            # Execute the query and calculate gross profit percentage
            result = self.cursor.execute(query).fetchall()
            column_names = [description[0] for description in self.cursor.description]

            # Calculate gross profit percentage and add it to the result
            result_with_percentage = []
            for row in result:
                item_id, item_name, date_sold, total_sold, total_revenue, total_cost, total_profit = row
                gross_profit_percentage = (total_profit / total_revenue) * 100 if total_revenue != 0 else 0
                result_with_percentage.append((item_id, item_name, str(date_sold), round(total_sold, 2), round(total_revenue, 2), round(total_cost, 2), round(total_profit, 2), round(gross_profit_percentage, 2)))

            return column_names + ['Gross Profit Percentage'], result_with_percentage
        except sqlite3.Error as e:
            # Print an error message if query execution fails
            print(f"An error occurred: {e}")
            return None, None

    def highlight_highest_cost_items(self):
        # SQL query to retrieve items with the highest cost to make
        query = """
            SELECT i.item_id,
                   i.item_name,
                   c.total_cost_to_make
            FROM item i
            JOIN cost_to_make c ON i.item_id = c.item_id
            ORDER BY c.total_cost_to_make DESC
        """
        try:
            # Execute the query to highlight highest cost items
            result = self.cursor.execute(query).fetchall()
            column_names = [description[0] for description in self.cursor.description]
            return column_names, result
        except sqlite3.Error as e:
            # Print an error message if query execution fails
            print(f"An error occurred: {e}")
            return None, None

    def __del__(self):
        # Close the database connection when the object is deleted
        if self.connection:
            self.connection.close()

# GUI class for the Coffee Shop Management application
class CoffeeShopGUI:
    """
    A class representing the graphical user interface for a coffee shop management application.

    Attributes:
        master (Tk): The root Tkinter window.
        text_area (ScrolledText): The text area for user input.
        execute_button (Button): The button for executing queries.
        profit_button (Button): The button for getting profit by item.
        highest_cost_button (Button): The button for highlighting highest cost items.
        exit_button (Button): The button for exiting the application.
        result_tree (Treeview): The Treeview widget for displaying query results.
        database (Database): The database connection.

    Methods:
        __init__(self, master): Initializes the GUI.
        create_widgets(self): Creates the GUI widgets.
        display_results(self, column_names, data): Displays query results in the Treeview widget.
        execute_query(self): Executes a user-entered SQL query and displays results.
        get_profit_by_item(self): Displays profit information by item.
        highlight_highest_cost_items(self): Highlights items with the highest cost to make.
        confirm_exit(self): Confirms exit and closes the application if confirmed.
    """
    def __init__(self, master):
        # Initialize the GUI
        self.master = master
        master.title("Coffee Shop Management")

        # Add an icon to the window
        icon_path = os.path.abspath("supp_files/plastic-coffee-cup.193x256.png")
        if os.path.exists(icon_path):
            icon = tk.PhotoImage(file=icon_path)
            master.iconphoto(True, icon)
        else:
            print(f"Icon not found at path: {icon_path}")

        # Create GUI widgets
        self.create_widgets()

        # Initialize the database connection
        self.database = Database()

    def create_widgets(self):
        # Create a scrolled text area for user input
        self.text_area = scrolledtext.ScrolledText(self.master, wrap=tk.WORD, width=40, height=10)
        self.text_area.pack(fill=tk.BOTH, expand=True, pady=10)

        # Configure themed buttons
        style = ttk.Style()
        style.configure("TButton", padding=6, relief="flat", background="#ccc")
        style.configure("Exit.TButton", padding=6, relief="flat", background="red")

        # Create buttons for executing queries and displaying results
        self.execute_button = ttk.Button(self.master, text="Execute Query", command=self.execute_query, style="TButton")
        self.execute_button.pack(pady=5)

        self.profit_button = ttk.Button(self.master, text="Get Profit by Item", command=self.get_profit_by_item, style="TButton")
        self.profit_button.pack(pady=5)

        self.highest_cost_button = ttk.Button(self.master, text="Highlight Highest Cost Items", command=self.highlight_highest_cost_items, style="TButton")
        self.highest_cost_button.pack(pady=5)

        self.exit_button = ttk.Button(self.master, text="Exit", command=self.confirm_exit, style="Exit.TButton")
        self.exit_button.pack(pady=5)


        # Create a Treeview widget for displaying query results
        self.result_tree = ttk.Treeview(self.master, columns=('Item ID', 'Item Name', 'Value'), show='headings')
        self.result_tree.heading('Item ID', text='Item ID')
        self.result_tree.heading('Item Name', text='Item Name')
        self.result_tree.heading('Value', text='Value')
        self.result_tree.pack(fill=tk.BOTH, expand=True, pady=10, padx=10)

        # Create a Canvas for Matplotlib charts
        self.canvas = tk.Canvas(self.master, width=500, height=300)
        self.canvas.pack(pady=10)

    def display_results(self, column_names, data):
        # Display query results in the Treeview widget
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

        # Plot a bar chart for total revenue by item
        self.plot_bar_chart(data)

    def plot_bar_chart(self, data):
        item_names = [row[1] for row in data]  # Assuming the item name is in the second column
        total_revenue = [row[4] for row in data]  # Assuming the total revenue is in the fifth column

        # Check if both item_names and total_revenue are non-empty
        if not item_names or not total_revenue:
            print("No data to plot.")
            return

        fig, ax = plt.subplots()
        ax.bar(item_names, total_revenue, color='blue')
        ax.set_xlabel('Item Name')
        ax.set_ylabel('Total Revenue')
        ax.set_title('Total Revenue by Item')

        # Embed the Matplotlib figure in the Tkinter window
        if hasattr(self, "canvas"):
            self.canvas.get_tk_widget().destroy()  # Destroy any existing Matplotlib canvas

        self.canvas = FigureCanvasTkAgg(fig, master=self.master)
        self.canvas_widget = self.canvas.get_tk_widget()
        self.canvas_widget.pack(side=tk.TOP, fill=tk.BOTH, expand=1)

        # Ensure that the canvas is updated properly
        self.canvas_widget.draw()
        self.canvas_widget.flush_events()




    def execute_query(self):
        # Execute a user-entered SQL query and display results
        user_input = self.text_area.get("1.0", tk.END).strip()

        if user_input.lower() == 'exit':
            self.confirm_exit()
        else:
            print(f"Executing query: {user_input}")
            try:
                column_names, result = self.database.execute_query(user_input)
                if result is not None:
                    self.display_results(column_names, result)
            except sqlite3.Error as e:
                self.result_tree.delete(*self.result_tree.get_children())
                print(f"Error executing query: {e}")

    def get_profit_by_item(self):
        # Display profit information by item
        try:
            column_names, result = self.database.get_profit_by_item()
            if result is not None:
                self.display_results(column_names, result)
        except sqlite3.Error as e:
            self.result_tree.delete(*self.result_tree.get_children())
            print(f"Error executing query: {e}")

    def highlight_highest_cost_items(self):
        # Highlight items with the highest cost to make
        try:
            column_names, result = self.database.highlight_highest_cost_items()
            if result is not None:
                self.display_results(column_names, result)
        except sqlite3.Error as e:
            self.result_tree.delete(*self.result_tree.get_children())
            print(f"Error executing query: {e}")

    def confirm_exit(self):
        # Confirm exit and close the application if confirmed
        result = messagebox.askyesno("Confirm Exit", "Are you sure you want to exit?")
        if result:
            self.master.quit()

# Main function to create and run the application
def main():
    root = tk.Tk()

    # Set up the style for the Exit button
    style = ttk.Style()
    style.configure("Exit.TButton", padding=6)

    # Create and run the CoffeeShopGUI instance
    gui = CoffeeShopGUI(root)
    
    # Set a fixed size for the window
    root.geometry("1000x800")
    
    root.mainloop()

# Run the main function if the script is executed directly
if __name__ == "__main__":
    main()
