USE StudentManagement;
UPDATE Students
SET
    Grade = 'F',
    MathScore = 32,
    ScienceScore = 35,
    EnglishScore = 38
WHERE StudentID = 5;

UPDATE Students
SET
    Grade = 'D',
    MathScore = 38,
    ScienceScore = 36,
    EnglishScore = 39
WHERE StudentID = 7;

UPDATE Students
SET
    Grade = 'F',
    MathScore = 25,
    ScienceScore = 33,
    EnglishScore = 29
WHERE StudentID = 14;
-- Updated some students data because at first we had 0 failed students so to show deviation in the output I edited some data entries  
SELECT * FROM Students;

-- query 1 : Average Grade by Gender
SELECT
s.Gender,
ROUND(AVG(e.Grade),2) AS AverageGrade
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
GROUP BY s.Gender;

-- query 2 : Pass Rate Per each Course
SELECT c.CourseName,
    ROUND(SUM(CASE WHEN e.Grade >= 40 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS PassRate
FROM Enrollments e
JOIN Courses c
ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

-- query 3 : Top 3 Students Overall
SELECT s.StudentID, s.Name,ROUND(AVG(e.Grade),2) AS AverageGrade
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY AverageGrade DESC
LIMIT 3;

-- query 4 : Students Enrolled in Multiple Courses
SELECT s.StudentID, s.Name, COUNT(e.CourseID) AS CoursesEnrolled
FROM Enrollments e
JOIN Students s
ON e.StudentID = s.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(e.CourseID) > 2;

-- query 5 : Improvement Report
SELECT StudentID, Name, MathScore, EnglishScore, (EnglishScore - MathScore) AS Improvement
FROM Students
WHERE EnglishScore > MathScore
ORDER BY Improvement DESC;