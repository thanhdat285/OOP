url = 'https://tickett.herokuapp.com/';

==== Sign up ====

/api/v1/sign_up

method: POST

data: :name, :email, :password, role: :seller or :customer



==== Sign in ====

/api/v1/customers/sign_in

method: POST

data: :email, :password

response: token

==== Get Locations ====

/api/v1/customers/locations

data: :page

==== Get Films ====

/api/v1/customers/films

data: :page


==== Show Film Detail ====

/api/v1/customers/films/:film_id   // vd = /api/v1/customers/films/1


==== Get Schedules ====

/api/v1/customers/schedules

headers: {Authorization: token}

data: :page, :location_id


==== Show Info Ticket Booking ====

/api/v1/customers/schedules/:schedule_id 

headers: {Authorization: token}

response: info film, info seats, seller's name, seat status: 2 dimensions array. [row, col, type, available?, price, ticket_id].
VD: ["A", 1, "VIP", true, 80000, ticket_id]

==== Book Ticket ====

	/api/v1/customers/tickets/book

	method: PUT

	headers: {Authorization: token}

	data: :ticket_id or :ticket_ids for array of tickets

==== Deposit =====

	/api/v1/customers/users/deposit

	method: PUT

	headers: {Authorization: token}

	data: :money

==== Update user info ==== 
	
	/api/v1/customers/users/info

	method: PUT

	headers: {Authorization: token}

	data: :name, :avatar

==== Update user password ====

	/api/v1/customers/users/update_password

	method: PUT

	headers: {Authorization: token}

	data: :password
	