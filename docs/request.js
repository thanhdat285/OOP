url = 'http://localhost:3000/';
$.ajax({
  url: url + 'api/v1/customers/locations',
  type: 'GET',
  dataType: 'JSON'
});

$.ajax({
  url: url + 'api/v1/customers/rooms',
  type: 'GET',
  dataType: 'JSON',
  data: {
    location_id: 1
  }
});

$.ajax({
  url: url + 'api/v1/customers/tickets',
  type: 'GET',
  dataType: 'JSON',
  data: {
    room_id: 1
  }
});

$.ajax({
  url: url + 'api/v1/customers/sign_in',
  type: 'POST',
  dataType: 'JSON',
  data: {sign_in: {
      email: 'thanhdath97@gmail.com',
      password: '12345678'
    }
  }
})
