# How to insert records to your Microsoft SQL Server database using Python


import configparser
import sys
import pyodbc as odbc

records = [
    ['Luis', 'C#', '2022-01-09', 2022], 
    ['Ariel', 'Python', None, 2021]
]

DRIVER = 'SQL Server'
SERVER_NAME = 'DESKTOP-HC1MDLH'
DATABASE_NAME = 'Python'

conn_string = f"""
    Driver={{{DRIVER}}};
    Server={SERVER_NAME};
    Database={DATABASE_NAME};
    Trust_Connection=yes;
"""

try:
    conn = odbc.connect(conn_string)
except Exception as e:
    print(e)
    print('task is terminated')
    sys.exit()
else:
    cursor = conn.cursor()

insert_statement = """
    INSERT INTO Student
    VALUES (?, ?, ?, ?)
"""

try:
    for record in records:
        print(record)
        cursor.execute(insert_statement, record)        
except Exception as e:
    cursor.rollback()
    print(e.value)
    print('transaction rolled back')
else:
    print('records inserted successfully')
    cursor.commit()
    cursor.close()

