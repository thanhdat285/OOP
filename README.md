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

==== History Book Tickets ====

	/api/v1/customers/tickets/history_book

	method: GET

	headers: {Authorization: token}

**API Người bán vé**

==== Create Film ====
	
	/api/v1/customers/films

	method: POST

	headers: {Authorization: token}

	data: :name (string), :kind (string), :duration (string), :release_date (string), :image (file)

	note: server will check role of current user (only seller can create), release_date will be converted to date, 
	eq: release_date: '18/10/2017'

==== Get rooms ====

	/api/v1/customers/rooms

	method: GET

	headers: {Authorization: token}

	data: :location_id

==== Create Schedule ====

	/api/v1/customers/schedules

	method: POST

	headers: {Authorization: token}

	data: :film_id, :room_id, :time_begin (string), :time_end (string), :price_VIP, :price_NORMAL 
		(eq: price_VIP: 80000, price_NORMAL: 40000)

	note: time_end, time_begin will be converted to datetime, eq: time_begin: '18/10/2017 13:00'

==== History Users Book Tickets ====

	/api/v1/customers/tickets/history_users_book

	method: GET

	headers: {Authorization: token}

	data: NULL or film_id or location_id
