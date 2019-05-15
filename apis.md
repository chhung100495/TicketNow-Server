# User
* Đăng ký tài khoản:
	[POST] http://localhost:4000/accounts/register (body: username, password, full_name, email, phone)

* Đăng nhập:
	[POST] http://localhost:4000/accounts/login (body: username, password)

* Lấy thông tin người dùng:
	[GET] http://localhost:4000/users/{id}

* Cập nhật thông tin người dùng:
	[POST] http://localhost:4000/users/update (body: id, username, full_name, gender, birthday, email, phone, address, credit_card_number, expiration_date)

* Thêm thông tin người dùng:
	[POST] http://localhost:4000/users/add (body: username, full_name, gender, birthday, email, phone, address, credit_card_number, expiration_date)

* Đổi mật khẩu tài khoản:
	[POST] http://localhost:4000/accounts/changePassword (body: id, current_password, new_password)

* Lấy danh sách các vé đã đặt mua của account:
	[GET] http://localhost:4000/bookings/account/{id}

* Lấy thông tin vé đã đặt mua dựa vào booking id và account id:
	[GET] http://localhost:4000/bookings/{id}/account/{id}

* Lấy danh sách các vị trí ghế của vé đã đặt theo account:
	[GET] http://localhost:4000/bookedSeats/account/{id}

* Lấy danh sách các combo của vé đã đặt theo account:
	[GET] http://localhost:4000/bookedCombos/account/{id}

* Đặt vé:
	[POST] http://localhost:4000/bookings/add
	```sh
    body: {
		"account_id": 1,
		"movie_showings_id": 1,
		"type": 0,
		"location_id": 1,
		"bookedSeats": [
			{
				"seat_id": 2,
				"price": 88000
			},
			{
				"seat_id": 3,
				"price": 88000
			}
		],
		"bookedCombos": [
			{
				"combo_id": 1,
				"price": 50000,
				"quantity": 1
			},
			{
				"combo_id": 1,
				"price": 50000,
				"quantity": 1
			}
		]
	}
	/* Nếu không có đặt combo: "bookedCombos": [] */
	```

# Movie
* Lấy danh sách các bộ phim được yêu thích nhất của các rạp (mặc định có 3 item):
	[GET] http://localhost:4000/movies/mostFavorite

* Lấy danh sách các bộ phim được yêu thích nhất của các rạp có sử dụng phân trang:
	[GET] http://localhost:4000/movies/mostFavorite?pageNo={pageNo}&size={size}

* Lấy danh sách các bộ phim đang chiếu của các rạp (mặc định có 6 item):
	[GET] http://localhost:4000/movies/showing

* Lấy danh sách các bộ phim đang chiếu của các rạp có sử dụng phân trang:
	[GET] http://localhost:4000/movies/showing?pageNo={pageNo}&size={size}

* Lấy danh sách các bộ phim sắp chiếu của các rạp (mặc định có 6 item):
	[GET] http://localhost:4000/movies/commingSoon

* Lấy danh sách các bộ phim sắp chiếu của các rạp có sử dụng phân trang:
	[GET] http://localhost:4000/movies/commingSoon?pageNo={pageNo}&size={size}

* Lấy danh sách thông tin rạp chiếu cùng xuất chiếu của 1 bộ phim:
	[GET] http://localhost:4000/movies/{id}/showing/{date}

* Lấy thông tin của các bộ phim theo id:
	[GET] http://localhost:4000/movies/{id}

* Lấy danh sách thông tin các vị trí ghế theo suất chiếu và vị trí rạp
	[GET] http://localhost:4000/seats/movieShowing/{movieShowingID}/location/{locationID}

# Event
* Lấy danh sách các sự kiện nổi bật:
	[GET] http://localhost:4000/events/hotEvent

* Lấy danh sách các sự kiện sắp diễn ra:
	[GET] http://localhost:4000/events/commingSoon

* Lấy danh sách các sự kiện sắp diễn ra có sử dụng phân trang:
	[GET] http://localhost:4000/events/commingSoon/{pageNo}

* Lấy thông tin của các sự kiện theo id:
	[GET] http://localhost:4000/events/{id}

* Lấy danh sách thông tin các vé sự kiện được bán ra theo ngày giờ:
	[GET] http://localhost:4000/events/{id}/sale/{datetime}

# The Others
* Lấy danh sách các sân vận động:
	[GET] http://localhost:4000/cineplex

* Lấy danh sách các hệ thống rạp:
	[GET] http://localhost:4000/venues