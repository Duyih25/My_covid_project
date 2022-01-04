# My covid project
 

## Các bướcc tiến hành :

### Bướcc 1: Lấy dữ liệu

Em đã lấy 1 bảng các số liệu (raw_data.csv) tại trang web Our world in data ( https://ourworldindata.org/covid-deaths ). Dữ liệu gồm các số liệu về số ca nhiễm, dân số, số ca tử vong,… trong đại dịch covid tính từ ngày 01/01/2020 đến ngày 27/12/2020

### Bước 2: Làm sạch dữ liệu (Data cleaning)

Đầu tiên, em chia bảng này thành chia thành 2 bảng (“covid cases.csv” và “vaccination and facilities.csv” và bỏ đi những cột không sử dụng tới)

* “covid cases.csv” gồm các thông tin về ca nhiễm, ca tử vong, ca bệnh nặng của các khu vực trên thế giới
* “vaccination and facilities.csv” gồm các thông tin về số lượng vaccine, số người đã tiêm và những thứ được chuẩn bị cho chống dịch

Đầu tiên làm sạch bảng “covid cases.csv”:
* Thêm tên lục địa các địa điểm chưa ghi tên lục địa
* Làm sạch cột “population”: em thấy có 1 vùng (Northern Cyprus) không ghi dân số nên em đã t́ìm thông tin trên mạng và ra đượcc dân số của vùng đó vào năm 2011 và 2017 => Tính tỉ lệ tăng dân số => Ta tính ra được số dân xấp xỉ của vùng đó
* Sau khi nh́ìn dữ liệu th́ì em thấy những giá trị null ở cột “total cases” và “total deaths” đa phần là lúc mà chưa có ca nhiễm nào nên em đã phủ những giá trị 0 vào
* Các vùng mà tất cả dòng đều có “total cases” và “total deaths” là 0 th́ì bỏ ra khỏi bảng 
* Lấp những giá trị null cột icu patients và hosp patients thành 0
* V́ì nếu cộng các cột “new cases” không khớp với “total cases” và “new deaths” không khớp với “total deaths” do 2 cột “new cases” và “new deaths” có những ô null là do ô đó không được người làm bảng điền vào chứ không phải do thời điểm đấy chưa xuất hiện ca nhiễm và ca tử vong nên em đã làm lại 2 cột “new cases” và “new deaths” dựa trên 2 cột “total cases” và “total deaths”

Làm sạch bảng “vaccination and facilities.csv”:
* Bỏ đi những dòng không hữu dụng cho viẹc phân tích
* Lấp các giá trị null ở cột continents
* Truy vấn ra ngày đầu tiên có người tiêm nên những giá trị null ở các cột “total test”, “total vaccinations”, “people vaccinated”, “people fully vaccinated” và “total booster” có thể thay bằng 0 với các những ngày trước ngày đó
* Cột “total vaccinations” và “total tests” có khá nhiều giá trị null và cột “new tests” và “new vaccinations” cũng vậy nên rất khó để sửa cho cột “new tests” và “new vaccinations” nên em bỏ 2 cột này đi để tránh cho việc phân tích sau này bị sai lệch nhiều

### Bước 3: T́ìm tương quan dữ liệu (Data correlation)

Trong file “export data.sql” và tạo ra 2 cột “case increasing rate” và “death increasing rate”
* “case increasing rate” được tính bằng tỉ lệ ca mới so với tổng số ca của ngày trước đó
* “death increasing death” được tính bằng số ca tử vong chia tổng số ca của ngày trước đó

Sau đó, xuất dữ liệu vào file “table for finding correlation.csv” . Tiếp đó tiến hành t́ìm tương quan của 2 cột này với những cột đã có từ đầu (FindingCorr.ipynb)


### Bước 4: Khám phá dữ liệu (Data exploring)

Trong file “Exploring data.sql” th́ em đã truy vấn 1 vài thông tin về ca nhiễm, tỉ lệ mắc, ca tử vong, số người được tiêm vaccine tại Việt Nam và các địa điểm trên thế giới

### Bước 5: Trực quan hóa dữ liệu (Data visualization)

Em có 2 Dashboard sử dụng Tableau:
* “Dashboard about Covid status in the world.twb” th́ì em kết nối Tableau với PostgreSQL rồi trực quan một số câu lệnh SQL em đã thực hiện tại file “Exploring data.sql”
* “Dashboard about increasing rate of cases and deaths.twb” th́ì đầu tiên em lấy file “table for finding correlation.csv” xuất ra 1 file excel “table for dashboard 2.xlsx” rồi kết nối Tableau với Excel để trực quan hóa
 (Em có xuất ra 2 file pdf để tiện cho việc quan sát kết quả)




