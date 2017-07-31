1.select title from book where publisher="Prentice Hall" order by year
2.select title from book group by publisher,year order by publisher asc;
3.select * from book where title like "%to%" order by price desc;
4.select distinct publisher from book s1 where (Select count(*) from book s2 where year between 2002 and 2004 and s1.publisher=s2.publisher)>=5;
5.select title from book order by price desc limit 10;
6.select title from book s1 where price=(select max(price) from book s2 where s1.publisher=s2.publisher);
7.select title from book b0 where price=(select max(price) from book b1 where price<>(select max(price) from book b2 where b1.publisher=b2.publisher) and b1.publisher=b0.publisher);
select title from book where price=(select max(s1.price) from book s1 where s1.price!=(select max(price) from book s2 where s1.publisher=s2.publisher));
8.select distinct publisher from book s1 where (select count(*) from book s2 where year="2002" and s1.title=s2.title)>=1 and (select count(*) from book s3 where year="2003" and s1.title=s3.title)>=1 and (select count(*) from book s4 where year="2004" and s1.title=s4.title)>=1;
9.Similar to 8.
select publisher from (select publisher from book where count(distinct year) from book >= 1 and year in last five years);
It lists the author, year of his last publication and number of different years it published the book.
select distinct b2.publisher,(select count(distinct b0.year) from book b0 where b0.publisher=b2.publisher) as distinct_yr,(select max(year) from book b3 where b2.publisher=b3.publisher) as year from book b2;
10.create view dummy3(first_author,number_of_books,publisher) as select s0.first_author,count(*) as number_of_books,s0.publisher from book s0 group by s0.first_author;
select  distinct first_author from dummy3 where number_of_books=(select max(number_of_books) from dummy3);
Not working => Select first_author from book s0 where((select count(*) from book s1 where s0.first_author=s1.first_author)>ALL(Select count(*) from book s2 where s0.first_author<>s2.first_author));
11.create view dummy3(first_author,number_of_books,publisher) as select s0.first_author,count(*) as number_of_books,s0.publisher from book s0 group by s0.first_author,publisher;
select  distinct author from dummy3 where number_of_books=(select max(number_of_books) from dummy3);
12.create view dummy(avg_price,publisher) as select avg(price),publisher from book group by publisher;
select publisher from dummy d0 where d0.avg_price>ALL(Select avg_price from dummy d1 where d0.publisher<>d1.publisher) ;
13. Similar Example:Find the difference between the average rating of movies released before 1980 and the average rating of movies
released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for
movies before 1980 and movies after.
select max(a1)-min(a1) from
(select avg(av1) a1 from
(select avg(stars) av1 from rating r join movie m on r.mid=m.mid where m.year < 1980
group by r.mid)
union select avg(av2) a1 from
(select avg(stars) av2 from rating r join movie m on r.mid=m.mid where m.year > 1980
group by r.mid))
14.select name from student s1 where rollno=(select rollno from studies s2 where sno=(select sno from subject s3 where stitle like "%DSA%" and s2.sno=s3.sno) and s1.rollno=s2.rollno);
15.select name from student s1 where department<>"coe" and rollno=(select rollno from buys s2 where s1.rollno=s2.rollno and title like "%database%") ;
16.select name from student s0 where rollno=(select rollno from buys s1 where title=(select title from covers s2 where sno=(select sno from studies s3 where s3.rollno=s0.rollno) and s2.title=s1.title) and s1.rollno=s0.rollno);
17.Similar to 16
18.select title from book s0 where title=(Select title from covers s1 where sno=(select sno from subject s2 where stitle like "%Database%") and s0.title=s1.title);
19. 20.create view dummy2(name,price) as select name,sum(price) as sum from buys s0,book s1,student s2 where s0.rollno=s2.rollno and s0.title=s1.title group by name;
select name from dummy2 where price>=400;
21. 22. 
23.select distinct title from buys where rollno in(select distinct b0.rollno from buys b0 where b0.title="Database");
24. 
25.select c0.sno from covers c0,covers c1 where c0.title=c1.title and c0.sno<>c1.sno;

Extra:
Question:How would you write a SQL query to find the Nth highest salary?
Solution:
SELECT *
FROM Employee Emp1
WHERE (N-1) = (SELECT COUNT(DISTINCT(Emp2.Salary))
FROM Employee Emp2
WHERE Emp2.Salary > Emp1.Salary)

Fill tuples from file:
Create a data.csv into the folder where existing database is present.
or create in home and copy to the database folder using
sudo cp data.csv /var/lib/mysql/test/data.csv
load data infile 'data.csv' into table book fields terminated by "," optionally enclosed by '"' (title,first_author,year,price,publisher)