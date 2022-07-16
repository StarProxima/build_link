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
 INSERT INTO public.objects(
	 address, square_meters, room_count, ceiling_height, repair, cost, status, max_date, min_date)
	VALUES ( 'Ул. Морозова 1, кв. 1', 35.4, 2, 2.6, true, 5000000, 'free', '2026-08-08', '2024-08-08');

INSERT INTO public.objects(
	 address, square_meters, room_count, ceiling_height, repair, cost, status, max_date, min_date)
	VALUES ( 'Ул. Морозова 1, кв. 2', 75.2, 7, 3.6, true, 50000000, 'free', '2026-08-08', '2024-08-08');

INSERT INTO public.objects(
	 address, square_meters, room_count, ceiling_height, repair, cost, status, max_date, min_date)
	VALUES ( 'Ул. Морозова 1, кв. 3', 21.4, 1, 2.7, true, 3000000, 'reservation', '2026-08-08', '2024-08-08');

INSERT INTO public.objects(
	 address, square_meters, room_count, ceiling_height, repair, cost, status, max_date, min_date)
	VALUES ('Ул. Морозова 1, кв. 4', 29.4, 2, 2.3, false, 3000000, 'free', '2026-08-08', '2024-08-08');
	
INSERT INTO public.objects(
	address, square_meters, room_count, ceiling_height, repair, cost, status, max_date, min_date)
	VALUES ( 'Ул. Морозова 1, кв. 5', 55.4, 4, 2.3, true, 9000000, 'removed', '2026-08-08', '2024-08-08');

INSERT INTO public.agents(
	firstname, lastname, patronymic, type, id_agency)
	VALUES ( 'Боб', 'Бобов', 'Бобович', 'a', 1);
INSERT INTO public.agents(
	firstname, lastname, patronymic, type, id_agency)
	VALUES ( 'Павел', 'Павлов', 'Павлович', 'a', 1);
INSERT INTO public.agents(
	firstname, lastname, patronymic, type)
	VALUES ( 'Артём', 'Павлов', 'Павлович', 'f');


INSERT INTO public.cards(
	firstname, lastname, patronymic, "number", note, id_agent, status)
	VALUES ('Боб', 'Викторов', 'Владимирович', '79189600438', 'Двухкомнатная квартира возле больницы 30 квадратов', 1, 'wait');
	
INSERT INTO public.cards(
	firstname, lastname, patronymic, "number", note, id_agent, status)
	VALUES ('Варфаломей', 'Иисакович', 'Григорьевич', '79919600439', 'Однокомнатная квартира с видом на озеро и рядом школа', 1, 'start');

INSERT INTO public.agencies(
	 name)
	VALUES ( 'NullExp');

INSERT INTO public.objects_clients(
	id_client, id_object)
	VALUES (1, 4);
INSERT INTO public.objects_clients(
	id_client, id_object)
	VALUES (1, 1);

INSERT INTO public.deal(
	 id_agent, id_object, name, date_start, date_end, note)
	VALUES ( 1, 1, 'Показ квартиры', '2022-05-08 12:35:29', '2007-05-08 14:35:29', 'Описание');
    
    UPDATE public.objects SET
    description = 'Двухкомнатная квартира в центре города. Больница, школа и магазины около подъезда.'::text, housing_complex = 'Весёлые истории' WHERE
    id = 4;
    UPDATE public.objects SET
    description = 'Квартира в центре города. Больница, школа и магазины около подъезда.'::text, housing_complex = 'Весёлые истории' WHERE
    id = 5;
    UPDATE public.objects SET
    description = 'Студия в центре города. Больница, школа и магазины около подъезда.'::text, housing_complex = 'Аквариум' WHERE
    id = 3;
    
    UPDATE public.objects SET
plan = 'https://img.kvartus.ru/server/php/files/base_kvartus/object/333/3332342/base_kvartus_object_333_3332342_9k4Z1NobHo4xmAnE7n5exK9t2hAwBzbAJ5pAJECgTxE5YRAV4v.jpeg' WHERE
id = 1;
UPDATE public.objects SET
plan = 'https://cdn-p.cian.site/images/8/024/607/gorodpark-pervyy-moskovskiy-moskva-jk-floor-plan-706420861-6.jpg                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ' WHERE
id = 2;
UPDATE public.objects SET
plan = 'https://www.kutuzov.ru/images/image2reality/rly.d.b/img-3458-331689.jpg' WHERE
id = 3;
UPDATE public.objects SET
plan = 'https://bazatut.ru/800x800/31/f7/31f722064d07dca71dc77a63d68b6fa9.jpeg' WHERE
id = 4;
UPDATE public.objects SET
plan = 'http://s1.citystar.ru/zh/781a0664a477ebe72604ac12ac7fa83d-fit-800x600.jpg                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ' WHERE
id = 5;
    
    
    """)
    # Получить результат
    records = cursor.fetchall()

except (Exception, Error) as error:
    print("Ошибка при работе с PostgreSQL", error)
finally:
    if connection:
        cursor.close()
        connection.close()