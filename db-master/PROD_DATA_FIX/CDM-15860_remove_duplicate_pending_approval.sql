/*
    CDM-15860
    User asked to delete the duplicates pending approval from inbox

*/

UPDATE routing 
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-15860'
WHERE routingid in ('032e2ac5-23e3-4054-b3b5-a522b3c91f52','b48827aa-76f1-4ee5-81cf-211e986b5e53', '019851c1-c2d6-419b-92b2-6297426fdf73');
