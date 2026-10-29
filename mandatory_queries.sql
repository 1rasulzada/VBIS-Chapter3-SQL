-- Exercise 3.11(a)
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Comp. Sci.';

-- Exercise 3.11(b)
SELECT ID, name
FROM student
WHERE ID NOT IN (
    SELECT ID
    FROM takes
    WHERE year < 2017
);

-- Exercise 3.11(c)
SELECT dept_name, MAX(salary) AS max_salary
FROM instructor
GROUP BY dept_name;

-- Exercise 3.11(d)
SELECT MIN(max_salary) AS lowest_max_salary
FROM (
    SELECT dept_name, MAX(salary) AS max_salary
    FROM instructor
    GROUP BY dept_name
) AS dept_max;

-- Exercise 3.15(a)
SELECT d.ID
FROM depositor d
JOIN account a ON d.account_number = a.account_number
JOIN branch b ON a.branch_name = b.branch_name
WHERE b.branch_city = 'Brooklyn'
GROUP BY d.ID
HAVING COUNT(DISTINCT b.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branch_city = 'Brooklyn'
);

-- Exercise 3.15(b)
SELECT SUM(amount) AS total_loan_amount
FROM loan;

-- Exercise 3.15(c)
SELECT branch_name
FROM branch
WHERE assets > SOME (
    SELECT assets
    FROM branch
    WHERE branch_city = 'Brooklyn'
);

-- Exercise 3.24
SELECT s.ID, s.name
FROM student s
JOIN advisor a ON s.ID = a.s_id
JOIN instructor i ON a.i_id = i.ID
WHERE s.dept_name = 'Accounting' 
  AND i.dept_name = 'Physics';

-- Exercise 3.25
SELECT dept_name
FROM department
WHERE budget > (
    SELECT budget
    FROM department
    WHERE dept_name = 'Philosophy'
)
ORDER BY dept_name ASC;