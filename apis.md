* Lấy danh sách các bộ phim đang chiếu của các rạp:
	[GET] http://localhost:4000/movies/showing

* Lấy danh sách các bộ phim được yêu thích nhất của các rạp:
	[GET] http://localhost:4000/movies/mostFavorite

* Lấy danh sách các bộ phim sắp chiếu của các rạp:
	[GET] http://localhost:4000/movies/commingSoon

* Lấy danh sách thông tin rạp chiếu cùng xuất chiếu của 1 bộ phim:
	[POST] http://localhost:4000/movies/showing/byDay (body: date (Unix Timestamp), movie_id)

* Lấy thông tin của các bộ phim theo id:
	[GET] http://localhost:4000/movies/<id>

* Đăng ký tài khoản:
	[POST] http://localhost:4000/accounts/register (body: username, password, full_name, email, phone)

* Đăng nhập:
	[POST] http://localhost:4000/accounts/login (body: username, password)

* Lấy thông tin người dùng:
	[GET] http://localhost:4000/users/<id>

* Cập nhật thông tin người dùng:
	[POST] http://localhost:4000/users/update (body: id, username, full_name, gender, birthday, email, phone, address, credit_card_number, expiration_date)

* Thêm thông tin người dùng:
	[POST] http://localhost:4000/users/add (body: username, full_name, gender, birthday, email, phone, address, credit_card_number, expiration_date)

* Đổi mật khẩu tài khoản:
	[POST] http://localhost:4000/accounts/changePassword (body: id, current_password, new_password)
