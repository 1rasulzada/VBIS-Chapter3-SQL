# SQL praktiki tapşırıq üzrə təhlil və izahlar

## 1. Ən çətin hesab etdiyiniz SQL sorğusu hansı oldu?
Spesifik olaraq hər hansı bir sorğu mənim üçün həddindən artıq çətin olmadı, çünki SQL operatorlarının işləmə prinsipi aydın idi. Lakin digərlərinə nisbətən daha çox diqqət və struktural analiz tələb edən sorğu **Exercise 3.28** oldu. Bu sorğuda bir müəllimin öz departamentində tədris olunan bütün kursları tədris edib-etmədiyini yoxlamaq lazımdı. SQL-də bölünmə (relational division) əməliyyatını birbaşa tək bir operatorla etmək mümkün olmadığı üçün `NOT EXISTS` və `EXCEPT` strukturlarını birgə istifadə etdim. Bu, sorğunun məntiqi ardıcıllığını tam doğru qurmaq baxımından ən çox diqqət tələb edən tapşırıq oldu.

## 2. Hansı sorğu üçün alt sorğu (subquery) istifadə etdiniz?
Alt sorğudan (subquery) geniş şəkildə **Exercise 3.25** və **Exercise 3.35** tapşırıqlarında istifadə etdim. Məsələn, 3.25 tapşırığında büdcəsi "Philosophy" (Fəlsəfə) departamentinin büdcəsindən böyük olan departamentləri seçmək üçün daxili sorğu qurdum:
`WHERE budget > (SELECT budget FROM department WHERE dept_name = 'Philosophy')`.
Burada daxili sorğu ilk növbədə Fəlsəfə departamentinin büdcə dəyərini hesablayıb xarici sorğuya ötürür, xarici sorğu isə bu dəyərdən böyük olan digər departamentləri filtrasiya edir. Həmçinin 3.35 tapşırığında maksimum qeydiyyatı olan bölməni tapmaq üçün `WITH` konstruksiyası (CTE) daxilində alt sorğudan istifadə etdim.

## 3. JOIN istifadə etdiyiniz bir nümunəni izah edin.
`JOIN` əməliyyatına **Exercise 3.24** tapşırığında müraciət etdim. Bu tapşırıqda Fizika departamentində çalışan müəllimlər tərəfindən məsləhətçi (`advisor`) təyin olunmuş Mühasibatlıq (`Accounting`) tələbələrini tapmaq tələb olunurdu. Məlumatlar üç fərqli cədvəldə (`student`, `advisor`, `instructor`) olduğu üçün onlar aşağıdakı kimi birləşdirildi:
- `student` cədvəli ilə `advisor` cədvəli tələbənin ID-sinə əsasən (`s.ID = a.s_id`),
- `advisor` cədvəli ilə `instructor` cədvəli müəllimin ID-sinə əsasən (`a.i_id = i.ID`) `INNER JOIN` vasitəsilə birləşdirildi.
Şərt hissəsində (`WHERE`) tələbənin departamentinin 'Accounting', müəllimin departamentinin isə 'Physics' olması filtri tətbiq edildi.

## 4. SQL sorğularını yazarkən qarşılaşdığınız bir problemi və onun həllini izah edin.
Sorğuları yazarkən və icra edərkən texniki baxımdan ciddi bir problem yaşamadım və xəta almadım, kodlar rahatlıqla icra olundu. Lakin proses zamanı diqqət yetirilməsi vacib olan əsas məqam, aqreqat funksiyaları (`COUNT`, `MAX`, `SUM`) istifadə edərkən `GROUP BY` bəndinin düzgün tənzimlənməsi idi. Məsələn, **Exercise 3.34** sorğusunda tələbələrin sayını qruplaşdırarkən `SELECT` hissəsində olan bütün qeyri-aqreqat sütunları (`course_id`, `sec_id`, `year`, `semester`) `GROUP BY` daxilinə əlavə etmək lazımdı. Bunu əvvəlcədən doğru nəzərə almaq məntiq xətalarının və sintaksis problemlərinin qarşısını aldı.
