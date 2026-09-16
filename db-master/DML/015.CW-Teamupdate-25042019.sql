
update team set teamtypekey ='LDSS' where teamname ='CJAMS Users'; 
UPDATE caseassignment SET fromworkeridno =fromsupervisoridno WHERE fromsupervisoridno IS NOT NULL  ;
UPDATE caseassignment SET fromsupervisoridno =NULL WHERE fromsupervisoridno IS NOT NULL ;