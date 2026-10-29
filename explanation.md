# SQL Praktiki Tapşırıq üzrə Təhlil və İzahlar

## 1. Ən çətin hesab etdiyiniz SQL sorğusu hansı oldu?
Tapşırıqlar arasında ən mürəkkəb hesab etdiyim sorğu **Exercise 3.15(a)** oldu. Bu sorğuda "Brooklyn" şəhərində yerləşən bütün filiallarda hesabı olan müştərilərin tapılması tələb olunurdu. Bu məsələ SQL-də Relyasiya Bölünməsi (Relational Division) məntiqinə söykənir. Sadə bir `JOIN` əməliyyatı kifayət etmədiyi üçün şəhəri Brooklyn olan müxtəlif filialların sayını `COUNT(DISTINCT branch_name)` ilə hesablamaq və `HAVING` şərti daxilində alt sorğu (subquery) vasitəsilə ümumi Brooklyn filiallarının sayına bərabər tutmaq lazımdı. Cədvəllərin (`depositor`, `account`, `branch`) bir-biri ilə düzgün əlaqələndirilməsi və aqreqasiya şərtinin doğru qurulması xüsusi diqqət tələb edirdi.

## 2. Hansı sorğu üçün alt sorğu (subquery) istifadə etdiniz?
Alt sorğudan geniş şəkildə **Exercise 3.25** və **Exercise 3.11(d)** tapşırıqlarında istifadə etdim. Məsələn, 3.25 tapşırığında büdcəsi "Philosophy" (Fəlsəfə) departamentinin büdcəsindən böyük olan departamentləri seçmək üçün daxili sorğu qurdum:
`WHERE budget > (SELECT budget FROM department WHERE dept_name = 'Philosophy')`.
Burada daxili sorğu ilk növbədə Fəlsəfə departamentinin büdcə dəyərini hesablayıb xarici sorğuya ötürür, xarici sorğu isə bu dəyərdən böyük olan digər departamentləri filtrasiya edir.

## 3. JOIN istifadə etdiyiniz bir nümunəni izah edin.
`JOIN` əməliyyatına **Exercise 3.24** tapşırığında müraciət etdim. Bu tapşırıqda Fizika departamentində çalışan müəllimlər tərəfindən məsləhətçi (`advisor`) təyin olunmuş Mühasibatlıq (`Accounting`) tələbələrini tapmaq tələb olunurdu. Məlumatlar üç fərqli cədvəldə (`student`, `advisor`, `instructor`) olduğu üçün onlar aşağıdakı kimi birləşdirildi:
- `student` cədvəli ilə `advisor` cədvəli tələbənin ID-sinə əsasən (`s.ID = a.s_id`),
- `advisor` cədvəli ilə `instructor` cədvəli müəllimin ID-sinə əsasən (`a.i_id = i.ID`) `INNER JOIN` vasitəsilə birləşdirildi.
Şərt hissəsində (`WHERE`) tələbənin departamentinin 'Accounting', müəllimin departamentinin isə 'Physics' olması filtri tətbiq edildi.

## 4. SQL sorğularını yazarkən qarşılaşdığınız bir problemi və onun həllini izah edin.
Sorğuları yazarkən qarşılaşdığım əsas problemlərdən biri **Exercise 3.11(a)** sorğusunda təkrarlanan (duplicate) nəticələrin alınması idi. Tələbə bir neçə dəfə Comp. Sci. dərsi ala bildiyi üçün `student` və `takes` cədvəllərini birləşdirəndə eyni tələbənin ID və adı nəticə siyahısında dəfələrlə təkrar olunurdu. Bu problemi həll etmək üçün `SELECT` ifadəsindən dərhal sonra `DISTINCT` açar sözündən istifadə etdim. `DISTINCT` təkrar olunan sətirləri təmizləyərək hər bir tələbənin nəticədə yalnız bir dəfə unikal şəkildə görünməsini təmin etdi.
