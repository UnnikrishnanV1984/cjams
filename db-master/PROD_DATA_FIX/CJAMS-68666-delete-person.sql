
/*
   Category/ Module  : Delete Person from case
   Root cause: Please provide your approval to remove the following person from case # 261030712441

                CJAMS PID# : 204983264
                D.O.B : 06/27/2026      
   Fix Provided :Data fix has been promoted to delete person
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

              UPDATE actor a 
              SET activeflag = 0, updatedby = 'CJAMS-68666', updatedon = now()
              WHERE a.actorid = '384f5757-aab2-4d1c-b751-b3c5406e164e'  AND a.activeflag = 1 ;

              UPDATE intakeservicerequestactor israa
              SET activeflag = 0, updatedby = 'CJAMS-68666', updatedon = now()
              WHERE israa.actorid = '384f5757-aab2-4d1c-b751-b3c5406e164e' AND israa.activeflag = 1;
             
              UPDATE actorrelationship ar
              SET activeflag = 0, updatedby = 'CJAMS-68666', updatedon = now()
              WHERE ar.servicecaseid ='5fe8576e-b05d-4c44-9e43-a36af9547dba' AND ar.person1id = 'f45e1eeb-c1e7-4fa4-9223-2c523a67a557' AND ar.activeflag = 1; 

              UPDATE personrole pr
              SET activeflag = 0, updatedby = 'CJAMS-68666', updatedon = now()
              WHERE pr.personroleid = '7091ea99-fd89-43c6-bd80-b64bdd1620b2'  AND pr.activeflag = 1 ;


              UPDATE personroletype prt
              SET activeflag = 0, updatedby = 'CJAMS-68666', updatedon = now() 
              WHERE prt.personroleid = '7091ea99-fd89-43c6-bd80-b64bdd1620b2' AND  prt.activeflag = 1 ;

              UPDATE personprogramarea  ppa
              SET activeflag = 0, updatedby = 'CJAMS-68666', updatedon = now() 
              WHERE ppa.personid = 'f45e1eeb-c1e7-4fa4-9223-2c523a67a557' :: uuid AND ppa.objectid = '5fe8576e-b05d-4c44-9e43-a36af9547dba' :: character varying 
              AND ppa.activeflag = 1;