import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def getHome(id):
    return getRequest("""SELECT * FROM public.objects Where id = """ + str(id))

def getCards(id):
    return getRequest("""SELECT firstname, lastname, patronymic, "number", note, id_agent
	FROM public.cards WHERE id_agent = """ + str(id))

def getRequest(sql_request):
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
        cursor.execute(sql_request)
        # Получить результат
        records = cursor.fetchone()

    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
    return records