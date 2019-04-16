* Lấy danh sách các bộ phim đang chiếu của các rạp: [GET] http://localhost:4000/movieShowings/
* Lấy thông tin bộ phim đang chiếu của các rạp theo id: [GET] http://localhost:4000/movieShowings/<id>
* Đăng ký tài khoản: [POST] http://localhost:4000/accounts/register (body: username, password, full_name, gender, email, phone)
* Đăng nhập: [POST] http://localhost:4000/accounts/register (body: username, password)
* Lấy thông tin khách hàng: [GET] http://localhost:4000/customers/<id>
* Cập nhật thông tin khách hàng: [POST] http://localhost:4000/customers/update (body: id, username, full_name, gender, email, phone, address, credit_card_number, expiration_date)
* Thêm thông tin khách hàng: [POST] http://localhost:4000/customers/add (body: username, full_name, gender, email, phone, address, credit_card_number, expiration_date)
* Đổi mật khẩu tài khoản: [POST] http://localhost:4000/accounts/changePassword (body: id, old_password, new_password)
