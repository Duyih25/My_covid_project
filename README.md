# My covid project
 

## Các b??c ti?n hành :

### B??c 1: L?y d? li?u

Em ?ã l?y 1 b?ng các s? li?u (raw_data.csv) mà em t?i t? trang web Our world in data xu?ng ( https://ourworldindata.org/covid-deaths ). D? li?u g?m các s? li?u v? s? ca nhi?m, dân s?, s? ca t? vong,… trong ??i d?ch covid tính t? ngày 01/01/2020 ??n ngày 27/12/2020

### B??c 2: Làm s?ch d? li?u (Data cleaning)

??u tiên, em chia b?ng này thành chia thành 2 b?ng (“covid cases.csv” và “vaccination and facilities.csv” và b? ?i nh?ng c?t không s? d?ng t?i)

* “covid cases.csv” g?m các thông tin v? ca nhi?m, ca t? vong, ca b?nh n?ng c?a các khu v?c trên th? gi?i
* “vaccination and facilities.csv” g?m các thông tin v? s? l??ng vaccine, s? ng ???c tiêm và nh?ng th? ???c chu?n b? ?? ch?ng d?ch

??u tiên làm s?ch b?ng “covid cases.csv”:
* Thêm tên l?c ??a các ??a ?i?m ch?a ghi tên l?c ??a
* Làm s?ch c?t “population”: em th?y có 1 vùng (Northern Cyprus) k ghi dân s? nên em ?ã tìm thông tin trên m?ng và ra ???c dân s? c?a vùng ?ó vào n?m 2011 và 2017 => Tính t? l? t?ng dân s? => Ta s? ra ???c s? dân x?p x? c?a vùng ?ó
* Sau khi nhìn d? li?u thì ta th?y nh?ng giá tr? null ? c?t “total cases” và “total deaths” ?a ph?n là lúc mà ch?a có ca nhi?m ? n??c ?ó nên em ?ã ph? nh?ng giá tr? null ? 2 c?t ?ó là 0
* Các vùng mà t?t c? dòng ??u có “total cases” và “total deaths” là 0 thì b? ra kh?i b?ng 
* L?p nh?ng giá tr? null ? icu patients và hosp patients thành 0
* Vì n?u c?ng các c?t “new cases” không kh?p v?i “total cases” và “new deaths” không kh?p v?i “total deaths” do 2 c?t “new cases” và “new deaths” có nh?ng ô null là do ô ?ó không ???c ng??i làm b?ng ?i?n vào ch? không ph?i do th?i ?i?m ??y ch?a xu?t hi?n ca nhi?m và ca t? vong nên em ?ã làm l?i 2 c?t “new cases” và “new deaths” d?a trên 2 c?t “total cases” và “total deaths”

Làm s?ch b?ng “vaccination and facilities.csv”:
* B? ?i nh?ng dòng không h?u d?ng cho vi?c phân tích
* L?p các giá tr? null ? c?t continents
* Truy v?n ra ngày ??u tiên có ng??i tiêm nên nh?ng giá tr? null ? các c?t “total test”, “total vaccinations”, “people vaccinated”, “people fully vaccinated” và “total booster” có th? thay b?ng 0 v?i các nh?ng ngày tr??c ngày ?ó
* C?t “total vaccinations” và “total tests” có khá nhi?u giá tr? null và c?t “new tests” và “new vaccinations” c?ng v?y nên r?t khó ?? s?a cho c?t “new tests” và “new vaccinations” nên s? b? 2 c?t này ?i ?? tránh cho vi?c phân tích sau này b? sai l?ch nhi?u

### B??c 3: Tìm t??ng quan d? li?u (Data correlation)

Trong file “export data.sql” và t?o ra 2 c?t “case increasing rate” và “death increasing rate”
* “case increasing rate” ???c tính b?ng t? l? ca m?i so v?i t?ng s? ca
* “death increasing death” ???c tính b?ng t? l? ca t? vong chia t?ng s? ca

Sau ?ó, xu?t d? li?u vào file “table for finding correlation.csv” . Ti?p ?ó ti?n hành tìm t??ng quan gi?a 2 c?t này v?i nh?ng c?t ?ã có t?i file (FindingCorr.ipynb)


### B??c 4: Khám phá d? li?u (Data exploring)

Trong file “Exploring data.sql” thì em ?ã truy v?n 1 vài thông tin v? ca nhi?m, t? l? m?c, ca t? vong, s? ng??i ???c tiêm vaccine

### B??c 5: Tr?c quan hóa d? li?u (Data visualization)

Em có 2 Dashboard s? d?ng Tableau:
* “Dashboard about Covid status in the world.twb” thì em k?t n?i Tableau v?i PostgreSQL r?i tr?c quan m?t s? câu l?nh SQL em ?ã th?c hi?n t?i file “Exploring data.sql”
* “Dashboard about increasing rate of cases and deaths.twb” thì ??u tiên em l?y file “table for finding correlation.csv” xu?t ra 1 file excel “table for dashboard 2.xlsx” r?i k?t n?i Tableau v?i Excel ?? tr?c quan hóa




