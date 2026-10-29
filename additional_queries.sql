-- Exercise 3.26
SELECT DISTINCT ID, course_id
FROM takes
GROUP BY ID, course_id
HAVING COUNT(*) >= 3
ORDER BY course_id;

-- Exercise 3.27
SELECT ID
FROM (
    SELECT ID, course_id
    FROM takes
    GROUP BY ID, course_id
    HAVING COUNT(*) >= 2
) AS repeated_courses
GROUP BY ID
HAVING COUNT(course_id) >= 3;

-- Exercise 3.28
SELECT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM course c
    WHERE c.dept_name = i.dept_name
    EXCEPT
    SELECT t.course_id
    FROM teaches t
    WHERE t.ID = i.ID
)
ORDER BY i.name;

-- Exercise 3.31
SELECT i.ID, i.name
FROM instructor i
WHERE i.ID NOT IN (
    SELECT t.ID
    FROM teaches t
    JOIN takes tk ON t.course_id = tk.course_id
                 AND t.sec_id = tk.sec_id
                 AND t.semester = tk.semester
                 AND t.year = tk.year
    WHERE tk.grade = 'A'
);

-- Exercise 3.32
SELECT i.ID, i.name
FROM instructor i
WHERE i.ID NOT IN (
    SELECT t.ID
    FROM teaches t
    JOIN takes tk ON t.course_id = tk.course_id
                 AND t.sec_id = tk.sec_id
                 AND t.semester = tk.semester
                 AND t.year = tk.year
    WHERE tk.grade = 'A'
)
AND i.ID IN (
    SELECT t.ID
    FROM teaches t
    JOIN takes tk ON t.course_id = tk.course_id
                 AND t.sec_id = tk.sec_id
                 AND t.semester = tk.semester
                 AND t.year = tk.year
    WHERE tk.grade IS NOT NULL
);

-- Exercise 3.33
SELECT DISTINCT c.course_id, c.title
FROM course c
JOIN section s ON c.course_id = s.course_id
JOIN time_slot ts ON s.time_slot_id = ts.time_slot_id
WHERE c.dept_name = 'Comp. Sci.'
  AND ts.end_hr >= 12;

-- Exercise 3.34
SELECT course_id, sec_id, year, semester, COUNT(ID) AS num
FROM takes
GROUP BY course_id, sec_id, year, semester
ORDER BY course_id, sec_id, year, semester, num;

-- Exercise 3.35
WITH section_count AS (
    SELECT course_id, sec_id, year, semester, COUNT(ID) AS num
    FROM takes
    GROUP BY course_id, sec_id, year, semester
)
SELECT course_id, sec_id, year, semester, num
FROM section_count
WHERE num = (SELECT MAX(num) FROM section_count);