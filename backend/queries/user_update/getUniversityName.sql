select name from university where university.id = (select education.university  from
 education where id = 123); 