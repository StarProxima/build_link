import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


try:
    connection = psycopg2.connect(user="user",
                                password="password123",
                                host="127.0.0.1",
                                port="5432",
                                database="postgres")
    connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    # Курсор для выполнения операций с базой данных
    cursor = connection.cursor()
    # Выполнение SQL-запроса
    cursor.execute("""
    Drop Table public.ad_object;
    Drop Table public.ad;
    Drop Table  public.agencies;
    Drop Table public.deal;
    Drop Table public.images;
    Drop Table public.objects_clients;
    Drop Table public.cards;
    Drop Table public.agents;
    Drop Table public.objects;
    """)
    # Получить результат
    records = cursor.fetchall()

except (Exception, Error) as error:
    print("Ошибка при работе с PostgreSQL", error)
finally:
    if connection:
        cursor.close()
        connection.close()