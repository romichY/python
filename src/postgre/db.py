import psycopg2
from src.postgre.sql import d
import os


def cur_data(param_list, rest_type):
    sql = d[rest_type]
    conn = psycopg2.connect(dbname=os.environ.get('DB_NAME', 'postgres'), user=os.environ.get('DB_USER', 'postgres'),
                            password=os.environ.get('DB_PASS', 'postgres'), host=os.environ.get('DB_HOST', 'localhost'),
                            port=os.environ.get('DB_PORT', 5433))
    cursor = conn.cursor()
    cursor.execute(sql
                   , param_list)
    records = cursor.fetchall()
    cursor.close()
    conn.close()
    return records
