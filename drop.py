import psycopg2

# Modify these variables according to your PostgreSQL configuration.
DATABASE = "YourDatabaseName"
USERNAME = "YourUsername"
PASSWORD = "YourPassword"
HOST = "localhost"
PORT = "5432"

connection = psycopg2.connect(
    dbname=DATABASE,
    user=USERNAME,
    password=PASSWORD,
    host=HOST,
    port=PORT
)
cursor = connection.cursor()

drop_queries = [
    "DROP TABLE torture_log;",
    "DROP TABLE torture_type;",
    "DROP TABLE case_log;",
    "DROP TABLE accusation_investigative_case;",
    "DROP TABLE violation;",
    "DROP TABLE investigative_case;",
    "DROP TABLE accusation_record;",
    "DROP TABLE accusation;",
    "DROP TABLE inquisition_process;",
    "DROP TABLE church;",
    "DROP TABLE prison;",
    "DROP TABLE bible_commandment;",
    "DROP TABLE bible;",
    "DROP TABLE commandment;",
    "DROP TABLE locality;",
    "DROP TABLE official;",
    "DROP TABLE punishment;",
    "DROP TABLE person;",
    "DROP TYPE gender;",
    "DROP TYPE case_log_result;",
    "DROP TYPE case_log_status;",
]

for query in drop_queries:
    cursor.execute(query)

# Commit the changes to the database.
connection.commit()
cursor.close()
connection.close()