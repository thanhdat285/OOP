url = 'https://tickett.herokuapp.com/';

==== Sign up ====

/api/v1/customers/sign_up

data: :name, :email, :password



==== Sign in ====

/api/v1/customers/sign_in

data: :email, :password

response: token

==== Get Locations ====

/api/v1/customers/locations

headers: {Authorization: token}

data: :page

==== Get Films ====

/api/v1/customers/films

headers: {Authorization: token}

data: :page
