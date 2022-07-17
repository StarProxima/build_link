import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from flask import Flask
from flask import request
import json
from fuzzywuzzy import fuzz


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

def makeWhere(ends):
    where = "where "
    if (ends[0][0] != -1 or ends[0][1] != -1) :
      if (ends[0][0] == -1):
        ends[0][0] = 0
      if (ends[0][1] == -1):
        ends[0][1] = 100000000000
      where += "square_meters <= "+ str(ends[0][1])+" and square_meters >= "+ str(ends[0][0])+" and  "
    if (ends[1][0] != -1 or ends[1][1] != -1):
      if (ends[1][0] == -1):
        ends[1][0] = 0
      if (ends[1][1] == -1):
        ends[1][1] = 100000000000
      where += "room_count <= "+ str(ends[1][1])+" and room_count >= "+ str(ends[1][0])+" and  "
    if (ends[2][0] != -1 or ends[2][1] != -1) :
      if (ends[2][0] == -1):
        ends[2][0] = 0
      if (ends[2][1] == -1):
        ends[2][1] = 100000000000
      where += "cost <= "+ str(ends[2][1])+" and cost >= "+ str(ends[2][0])+" and  "
    if (ends[3][0] != -1 or ends[3][1] != -1) :
      if (ends[3][0] == -1):
        ends[3][0] = 0
      if (ends[3][1] == -1):
        ends[3][1] = 100000000000
      where += "ceiling_height <= "+ str(ends[3][1])+" and ceiling_height >= "+ str(ends[3][0])+" and  "
    return where[0: len(where) - 6]

def foundSimilar(text, nameValues):
    for i in range(len(nameValues)):
        for keyWord in nameValues[i]:

            if (fuzz.WRatio(text, keyWord) > 70 and (abs(len(text)-len(keyWord)) <=4)):
                return i
    return -1

def extractValues(note):
    note = note.replace('-', ' ')

    realValues = [[-1,-1],[-1,-1],[-1,-1],[-1,-1]]
    nameValues = [["квадратные метры", "площадь", "квадратов", "кв м"],["комнаты", "комнатная", "квартира"],["цена","стоимость","рублей","миллионов","млн","тысяч"],["высота потолков","потолки"],]
    facts = note.split("\n")

    for fact in facts:
        count = -1
        type = -1
        supType = -1
        words = fact.split(' ')
        for j in range(len(words)):
            if (count != -1 and type != -1 and supType != -1):
                break
            if (words[j].isnumeric()):
                count = float(words[j])
            else:
                tmp = foundSimilar(words[j], [["больше", "более"],[ "меньше", "менее"]])
                if (tmp != -1):
                    supType = tmp
                    if (j > 0 and (words[j-1] == "не" or words[j-1] == "Не")):
                        supType+=1
                        supType%=2
                else:
                    type = foundSimilar(words[j], nameValues)
        if (count != -1 and type != -1):
            if (supType == 0):
                realValues[type] = [count, -1]
            elif (supType == 1):
                realValues[type] = [-1, count]
            else:
                realValues[type] = [count, count]
    return realValues

@app.route('/getCards')
def hello0():
    id = request.args.get('id')
    rows = getRequest("""SELECT firstname, lastname, patronymic, "number", note, id_agent, status
	FROM public.cards WHERE id_agent = """ + str(id))
    cards = []
    for row in rows:
        cards.append({'firstname':row[0],'lastname':row[1],'patronymic':row[2],'number':row[3],'note':row[4],'id_agent':row[5],'status':row[6]})
    return json.dumps(cards)

@app.route('/getHome')
def hello1():
    id = request.args.get('id')
    rows = getRequest("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date, plan, lat, lng
	FROM public.objects where id = """ + str(id))
    row = rows[0]
    cards = {'description':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],'housing_complex':row[8],'max_date':str(row[9]),'min_date':str(row[10]), 'plan':str(row[11]), 'lat':str(row[12]), 'lng':str(row[13])}
    return json.dumps(cards)

@app.route('/searchHouses')
def hello2():
    where = request.args.get('where')
    rows = getRequest("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date, plan, id, lat, lng
	FROM public.objects """ + str(where))
    cards = []
    for row in rows:
        cards.append({'description':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],'housing_complex':row[8],'max_date':str(row[9]),'min_date':str(row[10]), 'plan':str(row[11]), 'id':str(row[12]), 'lat':str(row[13]), 'lng':str(row[14])})
    return json.dumps(cards)

@app.route('/getImages')
def hello3():
    id = request.args.get('id')
    rows = getRequest("""SELECT * FROM public.images WHERE id_object = """ + str(id))
    cards = []
    for row in rows:
        cards.append(row[2])
    print(cards)
    return json.dumps(cards)

@app.route('/autoSearch')
def hello4():
    note = request.args.get('note')
    ends = extractValues(note)
    where = makeWhere(ends)
    rows = getRequest("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date, plan, id, lat, lng
	FROM public.objects """ + str(where))
    cards = []
    for row in rows:
        cards.append({'description':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],'housing_complex':row[8],'max_date':str(row[9]),'min_date':str(row[10]), 'plan':str(row[11]), 'id':str(row[12]), 'lat':str(row[13]), 'lng':str(row[14])})
    return json.dumps({'houses':cards,'filters':ends})