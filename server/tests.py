from fuzzywuzzy import fuzz

checks = "квартира квартиры квартиру квартир".split(' ')

for i in range(0, len(checks)):
    print(fuzz.ratio('квартир', "стол"))

nameValues = [["квадратные метры", "площадь", "квадратов", "кв м"],["комнаты", "комнатная", "квартира"],["цена","стоимость","рублей","миллионов","млн","тысяч"],["высота потолков","потолки"],]

def foundSimilar(text):
    print(1)
    for i in range(4):
        for keyWord in nameValues[i]:
            if (fuzz.WRatio(text, keyWord) > 70):
                return i
    return -1

foundSimilar("комнатная 3 миллиона 25 квадратов и более потолки не менее 3 м")
