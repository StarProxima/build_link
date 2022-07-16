import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from flask import Flask
from flask import request
import json

app = Flask(__name__)

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
        records = cursor.fetchall()

    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
    return records

@app.route('/recomend')
def hello0():
    id = request.args.get('id')
    rows = getRequest("""SELECT firstname, lastname, patronymic, "number", note, id_agent, status
	FROM public.cards WHERE id_agent = """ + str(id))
    cards = []
    for row in rows:
        cards.append({'firstname':row[0],'lastname':row[1],'patronymic':row[2],'number':row[3],'note':row[4],'id_agent':row[5],'status':row[6]})
    return json.dumps(cards)

@app.route('/recomend')
def hello1():
    id = request.args.get('id')
    rows = getRequest("""SELECT name, address, square_meters, room_count, ceiling_height, repair, cost, status
	FROM public.objects where id =""" + str(id))
    cards = []
    for row in rows:
        cards.append({'name':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],})
    return json.dumps(cards)