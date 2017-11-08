import requests
from bs4 import BeautifulSoup
import io
import uuid
import json

# collect films
def collect_films():
  req = requests.get("https://www.cgv.vn/default/movies/coming-soon-1.html")
  soup = BeautifulSoup(req.content, 'html.parser')
  # print(soup.prettify())
  films = []
  html_films = soup.find_all(attrs={'class': 'film-lists'})
  for film in html_films:
    img = film.find(attrs={'class': 'product-images'}).find('img')['src']
    name = film.find(attrs={'class': 'product-name'}).find('a').text.strip()
    infos = film.find_all(attrs={'class': 'cgv-movie-info'})
    url_detail = film.find(attrs={'class': 'product-images'}).find('a')['href']
    kind = infos[0].find(attrs={'class': 'cgv-info-normal'}).text.strip()
    duration = infos[1].find(attrs={'class': 'cgv-info-normal'}).text.strip()
    start_date = infos[2].find(attrs={'class': 'cgv-info-normal'}).text.strip()

    req_detail = requests.get(url_detail)
    parser_html_detail = BeautifulSoup(req_detail.content, 'html.parser')
    content = parser_html_detail.find(attrs={'class': 'tab-content'}).find(attrs={'class': 'std'}).text.strip()

    img_data = requests.get(img).content
    img_name = uuid.uuid4().hex + '.png'
    # with open('films/' + img_name, 'wb') as handler:
    #   handler.write(img_data)
    with open('public/images/films/' + img_name, 'wb') as handler:
      handler.write(img_data)
    films.append({
      'img': img_name,
      'name': name,
      'kind': kind,
      'duration': duration,
      'start_date': start_date,
      'content': content
    })

  with io.open('films.csv', 'w+', encoding='utf-8') as file:
    file.write('name,img,kind,duration,start_date,content\n')
    for film in films:
      line = film['name'] + '|' + film['img'] + '|' + film['kind'] + '|' + film['duration']+'|'+film['start_date']+'|' + film['content'] + '\n'
      file.write(line)

def collect_locations():
  req = requests.get("https://www.cgv.vn/default/cinox/site/")
  soup = BeautifulSoup(req.content, 'html.parser')
  locations = []
  html_locations = soup.find(attrs={'class': 'cinemas-list'}).find_all('span')
  for location in html_locations:
    locations.append(location.text.strip())
  with io.open('locations/locations.csv', 'w+', encoding='utf-8') as file:
    file.write('name\n')
    for location in locations:
      file.write(location + '\n')

# collect_films()
# collect_locations()

# oop_url = 'http://localhost:3000/'
oop_url = 'https://tickett.herokuapp.com/'
token = ''

def sign_up():
  data = {'name': 'Thanh Dat', 'email': 'thanhdath97@gmail.com', 'password': '123456'}
  req = requests.post(oop_url + 'api/v1/sign_up', json=data)
  print(req.text)

def sign_in():
  data = {'email': 'thanhdath97@gmail.com', 'password': '123456'}
  req = requests.post(oop_url + 'api/v1/customers/sign_in', json=data)
  response = json.loads(req.text)
  print(response)
  global token
  token = response['token']

def get_locations():
  req = requests.get(oop_url + 'api/v1/customers/locations')
  res = json.loads(req.text)
  return res['data']

def get_films():
  req = requests.get(oop_url + 'api/v1/customers/films')
  res = json.loads(req.text)
  return res['data']

def get_film(film_id):
  req = requests.get(oop_url + 'api/v1/customers/films/'+str(film_id))
  res = json.loads(req.text)
  return res['data']

def get_rooms(location_id):
  req = requests.get(oop_url + 'api/v1/customers/rooms',
    params={'location_id': location_id},
    headers={'Authorization': token})
  res = json.loads(req.text)
  return res['data']

def get_schedules(location_id):
  req = requests.get(oop_url + 'api/v1/customers/schedules',
    params={'location_id': location_id},
    headers={'Authorization': token})
  res = json.loads(req.text)
  return res['data']

def get_schedules_by_film_id(film_id):
  req = requests.get(oop_url + 'api/v1/customers/schedules',
    params={'film_id': film_id},
    headers={'Authorization': token})
  res = json.loads(req.text)
  return res['data']

def get_schedule(schedule_id):
  req = requests.get(oop_url + 'api/v1/customers/schedules/'+str(schedule_id),
    headers={'Authorization': token})
  res = json.loads(req.text)
  return res['data']

def book_ticket(ticket_id):
  req = requests.post(oop_url + 'api/v1/customers/tickets/book', headers={'Authorization': token},
    json={'id': ticket_id})
  res = json.loads(req.text)
  return res

# sign_in()
# print(get_schedule(1))


# test book ticket
# sign_in()
# print(book_ticket(2))
# print(book_ticket(2))


# full test except test book ticket
sign_up()
sign_in()

print(get_schedules_by_film_id(1))

# print('Films')
# films = get_films()
# print(films)

# for film in films:
#   print(get_film(film['id']))

# print('Location')
# locations = get_locations()
# print(locations)

# for location in locations:
#   print('Location ' + str(location['id']) + ' Rooms')
#   print(get_rooms(location['id']))

#   print('Location ' + str(location['id']) + ' Schedules')
#   schedules = get_schedules(location['id'])
#   print(schedules)

#   for schedule in schedules:
#     print(get_schedule(schedule['id']))

# req = requests.get(oop_url + 'api/v1/customers/films', headers={'Authorization': token})