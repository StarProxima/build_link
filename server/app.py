import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from flask import Flask
from flask import request
import json
import natasha
from fuzzywuzzy import fuzz


app = Flask(__name__)
nameValues = [["квадратные метры", "площадь", "квадратов", "кв м"],["комнаты", "комнатная", "квартира"],["цена","стоимость","рублей","миллионов","млн","тысяч"],["высота потолков","потолки"],]

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

def foundSimilar(text):
    for i in range(4):
        for keyWord in nameValues[i]:
            if (fuzz.WRatio(text, keyWord) > 70):
                return i
    return -1

def extractValues(note):
    note = note.replace('-', ' ')
    realValues = [-1,-1,-1,-1]

    segmenter = natasha.Segmenter()
    morph_vocab = MorphVocab()

    emb = natasha.NewsEmbedding()
    morph_tagger = natasha.NewsMorphTagger(emb)
    syntax_parser = natasha.NewsSyntaxParser(emb)
    doc = natasha.Doc(note)
    doc.segment(segmenter)
    doc.tag_morph(morph_tagger)
    doc.parse_syntax(syntax_parser)

    sent = doc.sents[0]

    for i in range(len(sent.syntax.tokens)):
        if (sent.morph.tokens[i].pos == "NUM"):
            parent_id = int(sent.syntax.tokens[i].head_id[2:])-1
            similar = foundSimilar(sent.syntax.tokens[parent_id].text)
            if similar != -1:
                realValues[similar] = float(sent.syntax.tokens[i].text)

    print(1)

#extractValues("3 комнатная 3 миллиона 25 квадратов и более потолки не менее 3 м")

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
    print("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date
	FROM public.objects """ + str(where))
    rows = getRequest("""SELECT description, address, square_meters, room_count, ceiling_height, repair, cost, status, housing_complex, max_date, min_date, plan
	FROM public.objects """ + str(where))
    cards = []
    for row in rows:
        cards.append({'description':row[0],'address':row[1],'square_meters':row[2],'room_count':row[3],'ceiling_height':row[4],'repair':row[5],'cost':row[6],'status':row[7],'housing_complex':row[8],'max_date':str(row[9]),'min_date':str(row[10]), 'plan':str(row[11])})
    return json.dumps(cards)