import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from flask import Flask
from flask import request
import json
import natasha
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

def foundSimilar(text, nameValues):
    for i in range(len(nameValues)):
        for keyWord in nameValues[i]:
            if (fuzz.WRatio(text, keyWord) > 70):
                return i
    return -1

def extractValues(note):
    note = note.replace('-', ' ')

    realValues = [-1,-1,-1,-1]
    nameValues = [["квадратные метры", "площадь", "квадратов", "кв м"],["комнаты", "комнатная", "квартира"],["цена","стоимость","рублей","миллионов","млн","тысяч"],["высота потолков","потолки"],]


    segmenter = natasha.Segmenter()

    emb = natasha.NewsEmbedding()
    morph_tagger = natasha.NewsMorphTagger(emb)
    syntax_parser = natasha.NewsSyntaxParser(emb)
    doc = natasha.Doc(note)
    doc.segment(segmenter)
    doc.tag_morph(morph_tagger)
    doc.parse_syntax(syntax_parser)

    for sent in doc.sents:
        for i in range(len(sent.syntax.tokens)):
            if (sent.morph.tokens[i].pos == "NUM"):
                parent_id = int(sent.syntax.tokens[i].head_id[2:])-1
                similar = foundSimilar(sent.syntax.tokens[parent_id].text, nameValues)
                if similar != -1:
                    subSimilar = -1
                    subindex = -1
                    for j in range(len(sent.syntax.tokens)):
                        if (int(sent.syntax.tokens[j].head_id[2:])-1 == i):
                            subindex = j
                            subSimilar = foundSimilar(sent.syntax.tokens[j].text, [["больше", "более"],[ "меньше", "менее"]])
                            break
                    
                    if (subSimilar != -1 and j > 0 and (sent.syntax.tokens[j-1].text == "не" or sent.syntax.tokens[j-1].text == "Не")):
                        subSimilar+=1
                        subSimilar%=2

                    if (subSimilar == 0):
                        realValues[similar] = (float(sent.syntax.tokens[i].text), -1)
                    elif (subSimilar == 1):
                        realValues[similar] = (-1, float(sent.syntax.tokens[i].text))
                    else:
                        realValues[similar] = (float(sent.syntax.tokens[i].text), float(sent.syntax.tokens[i].text))

    print(1)

extractValues("менее 3 комнатная. 3 миллиона. 25 и больше квадратов. потолки не менее 3 м")

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
    rows = getRequest("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date, plan
	FROM public.objects where id = """ + str(id))
    row = rows[0]
    cards = {'description':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],'housing_complex':row[8],'max_date':str(row[9]),'min_date':str(row[10]), 'plan':str(row[11])}
    return json.dumps(cards)

@app.route('/searchHouses')
def hello2():
    where = request.args.get('where')
    rows = getRequest("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date, plan, id
	FROM public.objects """ + str(where))
    cards = []
    for row in rows:
        cards.append({'description':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],'housing_complex':row[8],'max_date':str(row[9]),'min_date':str(row[10]), 'plan':str(row[11]), 'id':str(row[12])})
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