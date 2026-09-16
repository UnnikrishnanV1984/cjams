/*
   Issue Description: CJAMS-68797
   Category/ Module  : Others
   Root cause: user wants to delete persons form others tab
        remove the persons from the CPS IR# 261023827749

            Client ID# 204932123 William Boyce
            Cleitn ID# 204932159 Jessica Boyce  
   Pull request# for data fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

            UPDATE actor a 
            SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
            WHERE a.actorid = '382fe5d4-8e5d-4c24-9bb1-022931c674fc' AND a.intakeserviceid = 'c814da5e-5fe3-4e43-adee-aa9c13602769'  AND a.activeflag = 1 ;

            UPDATE intakeservicerequestactor israa
            SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
            WHERE israa.actorid = '382fe5d4-8e5d-4c24-9bb1-022931c674fc' AND israa.activeflag = 1;

            UPDATE actorrelationship ar
            SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
            WHERE ar.intakeserviceid = 'c814da5e-5fe3-4e43-adee-aa9c13602769' AND ar.person1id = 'd5a1723b-893e-432c-8c4a-72e88b9c1424' AND ar.activeflag = 1; 


              UPDATE personrole pr
              SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
              WHERE pr.personroleid IN ('0e3299fd-39da-48a0-b907-93a95229f11f','e7a7f090-5877-4158-9d23-44b8070a2f07')  AND pr.activeflag = 1 ;


              UPDATE personprogramarea  ppa
              SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now() 
              WHERE ppa.personid = 'd5a1723b-893e-432c-8c4a-72e88b9c1424' :: uuid AND ppa.objectid = 'c814da5e-5fe3-4e43-adee-aa9c13602769' :: character varying
              AND ppa.activeflag = 1;

              UPDATE personroletype prt
              SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now() 
              WHERE prt.personroleid IN ('0e3299fd-39da-48a0-b907-93a95229f11f','e7a7f090-5877-4158-9d23-44b8070a2f07') AND  prt.activeflag = 1 ;
                            




                             UPDATE actor a 
            SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
            WHERE a.actorid = 'ef0c9359-0e05-4335-8a2b-af4b6a36eb4d' AND a.intakeserviceid = 'c814da5e-5fe3-4e43-adee-aa9c13602769'  AND a.activeflag = 1 ;

            UPDATE intakeservicerequestactor israa
            SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
            WHERE israa.actorid = 'ef0c9359-0e05-4335-8a2b-af4b6a36eb4d' AND israa.activeflag = 1;

            UPDATE actorrelationship ar
            SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
            WHERE ar.intakeserviceid = 'c814da5e-5fe3-4e43-adee-aa9c13602769' AND ar.person1id = 'f0095a3a-e780-4581-9770-1924b496db3d' AND ar.activeflag = 1; 


              UPDATE personrole pr
              SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now()
              WHERE pr.personroleid IN ('70d0ccc4-13e0-4a8b-b042-0cdd749989b0','7a5e6681-2504-4152-957a-abf01fc756bd')  AND pr.activeflag = 1 ;


              UPDATE personprogramarea  ppa
              SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now() 
              WHERE ppa.personid = 'f0095a3a-e780-4581-9770-1924b496db3d' :: uuid AND ppa.objectid = 'c814da5e-5fe3-4e43-adee-aa9c13602769' :: character varying
              AND ppa.activeflag = 1;

              UPDATE personroletype prt
              SET activeflag = 0, updatedby = 'CJAMS-68797', updatedon = now() 
              WHERE prt.personroleid IN ('70d0ccc4-13e0-4a8b-b042-0cdd749989b0','7a5e6681-2504-4152-957a-abf01fc756bd') AND  prt.activeflag = 1 ;
                            