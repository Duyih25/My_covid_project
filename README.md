# My covid project
 

## C�c b??c ti?n h�nh :

### B??c 1: L?y d? li?u

Em ?� l?y 1 b?ng c�c s? li?u (raw_data.csv) m� em t?i t? trang web Our world in data xu?ng ( https://ourworldindata.org/covid-deaths ). D? li?u g?m c�c s? li?u v? s? ca nhi?m, d�n s?, s? ca t? vong,� trong ??i d?ch covid t�nh t? ng�y 01/01/2020 ??n ng�y 27/12/2020

### B??c 2: L�m s?ch d? li?u (Data cleaning)

??u ti�n, em chia b?ng n�y th�nh chia th�nh 2 b?ng (�covid cases.csv� v� �vaccination and facilities.csv� v� b? ?i nh?ng c?t kh�ng s? d?ng t?i)

* �covid cases.csv� g?m c�c th�ng tin v? ca nhi?m, ca t? vong, ca b?nh n?ng c?a c�c khu v?c tr�n th? gi?i
* �vaccination and facilities.csv� g?m c�c th�ng tin v? s? l??ng vaccine, s? ng ???c ti�m v� nh?ng th? ???c chu?n b? ?? ch?ng d?ch

??u ti�n l�m s?ch b?ng �covid cases.csv�:
* Th�m t�n l?c ??a c�c ??a ?i?m ch?a ghi t�n l?c ??a
* L�m s?ch c?t �population�: em th?y c� 1 v�ng (Northern Cyprus) k ghi d�n s? n�n em ?� t�m th�ng tin tr�n m?ng v� ra ???c d�n s? c?a v�ng ?� v�o n?m 2011 v� 2017 => T�nh t? l? t?ng d�n s? => Ta s? ra ???c s? d�n x?p x? c?a v�ng ?�
* Sau khi nh�n d? li?u th� ta th?y nh?ng gi� tr? null ? c?t �total cases� v� �total deaths� ?a ph?n l� l�c m� ch?a c� ca nhi?m ? n??c ?� n�n em ?� ph? nh?ng gi� tr? null ? 2 c?t ?� l� 0
* C�c v�ng m� t?t c? d�ng ??u c� �total cases� v� �total deaths� l� 0 th� b? ra kh?i b?ng 
* L?p nh?ng gi� tr? null ? icu patients v� hosp patients th�nh 0
* V� n?u c?ng c�c c?t �new cases� kh�ng kh?p v?i �total cases� v� �new deaths� kh�ng kh?p v?i �total deaths� do 2 c?t �new cases� v� �new deaths� c� nh?ng � null l� do � ?� kh�ng ???c ng??i l�m b?ng ?i?n v�o ch? kh�ng ph?i do th?i ?i?m ??y ch?a xu?t hi?n ca nhi?m v� ca t? vong n�n em ?� l�m l?i 2 c?t �new cases� v� �new deaths� d?a tr�n 2 c?t �total cases� v� �total deaths�

L�m s?ch b?ng �vaccination and facilities.csv�:
* B? ?i nh?ng d�ng kh�ng h?u d?ng cho vi?c ph�n t�ch
* L?p c�c gi� tr? null ? c?t continents
* Truy v?n ra ng�y ??u ti�n c� ng??i ti�m n�n nh?ng gi� tr? null ? c�c c?t �total test�, �total vaccinations�, �people vaccinated�, �people fully vaccinated� v� �total booster� c� th? thay b?ng 0 v?i c�c nh?ng ng�y tr??c ng�y ?�
* C?t �total vaccinations� v� �total tests� c� kh� nhi?u gi� tr? null v� c?t �new tests� v� �new vaccinations� c?ng v?y n�n r?t kh� ?? s?a cho c?t �new tests� v� �new vaccinations� n�n s? b? 2 c?t n�y ?i ?? tr�nh cho vi?c ph�n t�ch sau n�y b? sai l?ch nhi?u

### B??c 3: T�m t??ng quan d? li?u (Data correlation)

Trong file �export data.sql� v� t?o ra 2 c?t �case increasing rate� v� �death increasing rate�
* �case increasing rate� ???c t�nh b?ng t? l? ca m?i so v?i t?ng s? ca
* �death increasing death� ???c t�nh b?ng t? l? ca t? vong chia t?ng s? ca

Sau ?�, xu?t d? li?u v�o file �table for finding correlation.csv� . Ti?p ?� ti?n h�nh t�m t??ng quan gi?a 2 c?t n�y v?i nh?ng c?t ?� c� t?i file (FindingCorr.ipynb)


### B??c 4: Kh�m ph� d? li?u (Data exploring)

Trong file �Exploring data.sql� th� em ?� truy v?n 1 v�i th�ng tin v? ca nhi?m, t? l? m?c, ca t? vong, s? ng??i ???c ti�m vaccine

### B??c 5: Tr?c quan h�a d? li?u (Data visualization)

Em c� 2 Dashboard s? d?ng Tableau:
* �Dashboard about Covid status in the world.twb� th� em k?t n?i Tableau v?i PostgreSQL r?i tr?c quan m?t s? c�u l?nh SQL em ?� th?c hi?n t?i file �Exploring data.sql�
* �Dashboard about increasing rate of cases and deaths.twb� th� ??u ti�n em l?y file �table for finding correlation.csv� xu?t ra 1 file excel �table for dashboard 2.xlsx� r?i k?t n?i Tableau v?i Excel ?? tr?c quan h�a




