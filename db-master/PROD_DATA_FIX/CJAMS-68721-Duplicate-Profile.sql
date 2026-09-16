/*
            -- Issue Description: 'CJAMS-68721'-Duplicate-Profile            
                Category/ Module: 
                -- Root cause: User Request
               user wrongly added person , having CIS ID - 401042336, user wants to delete this person from this case and add the correct one CIS 47006044, having MDM ID - MDT-12887377
                User has added one contact Note and assessment for this child
            -- Pull request# N/A
            -- Reason why no related code fix: N/A
            -- Status of the code fix if already submitted and expected prod fix date: TBD
*/





            UPDATE actor a 
            SET personid='6061a4ed-17be-4fb5-8e39-73e78a8f94fd', updatedby = 'CJAMS-68721', updatedon = now()
            WHERE a.actorid = '2920de3b-4f5c-4330-89fa-2ce1cf969229' AND a.intakeserviceid = '4929e629-2225-4e2a-b3c1-628fdc546ba0'  AND a.activeflag = 1 ;

            UPDATE intakeservicerequestactor israa
            SET personid='6061a4ed-17be-4fb5-8e39-73e78a8f94fd' , actorid = (select actorid from actor where updatedby = 'CJAMS-68721'), updatedby = 'CJAMS-68721', updatedon = now()
            WHERE israa.actorid = '2920de3b-4f5c-4330-89fa-2ce1cf969229' AND israa.activeflag = 1;

             UPDATE actorrelationship ar
            SET person1id='6061a4ed-17be-4fb5-8e39-73e78a8f94fd' , intakeservicerequestactorid = (select intakeservicerequestactorid from intakeservicerequestactor where updatedby = 'CJAMS-68721'), updatedby = 'CJAMS-68721', updatedon = now()
            WHERE ar.intakeserviceid = '4929e629-2225-4e2a-b3c1-628fdc546ba0' AND ar.person1id = 'af58f012-5539-44af-b77a-ca14bc47ab1b' AND ar.activeflag = 1; 

              UPDATE personrole pr
              SET personid='6061a4ed-17be-4fb5-8e39-73e78a8f94fd', updatedby = 'CJAMS-68721', updatedon = now()
              WHERE pr.personroleid = 'b86352c7-87db-458b-800c-ae23aaa2767f'  AND pr.activeflag = 1 ;

              UPDATE personprogramarea  ppa
              SET personid='6061a4ed-17be-4fb5-8e39-73e78a8f94fd', updatedby = 'CJAMS-68721', updatedon = now() 
              WHERE ppa.personid = 'af58f012-5539-44af-b77a-ca14bc47ab1b' :: uuid AND ppa.objectid = '4929e629-2225-4e2a-b3c1-628fdc546ba0' :: character varying
              AND ppa.activeflag = 1;
            



UPDATE cjams.contactparticipant
SET intakeservicerequestactorid=(select intakeservicerequestactorid from intakeservicerequestactor where updatedby = 'CJAMS-68721'),participantid=(select intakeservicerequestactorid from intakeservicerequestactor where updatedby = 'CJAMS-68721'), updatedby ='CJAMS-68721', updatedon = now() 
WHERE progressnoteid='e2787ce9-9df4-40ab-9f2c-bd5e18d876f5'::uuid
and activeflag = 1;


UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{all_childs_json}', '[
        {
            "name": "KADEN  PRESTON",
            "age": "12 Yrs",
            "cjamspid": "3591020"
        },
        {
            "name": " Halo  Torrence ",
            "age": "3 Yrs",
            "cjamspid": "201537010"
        },
        {
            "name": " Kyon  Preston ",
            "age": "10 Yrs",
            "cjamspid": "200243468"
        },
        {
            "name": "Carter J Smith",
            "age": "15 Yrs",
            "cjamspid": "3595694"
        },
        {
            "name": "KAMAL  PRESTON",
            "age": "8 Yrs",
            "cjamspid": "4166635"
        },
        {
            "name": " Chosen  Torrence ",
            "age": "1 Yrs",
            "cjamspid": "204279658"
        }
    ]') ,updatedby ='CJAMS-68721', updatedon =now()
WHERE assessmentid = '2e32d6bd-6bb9-48ca-bd03-67789e3c5544' and activeflag = 1;


update assessmentactor 
set intakeservicerequestactorid='e9b1ed2a-0341-4c9c-9f3a-984b113715d6', updatedby = 'CJAMS-68721', updatedon = now() 
where assessmentactorid='a3fd59ee-91f5-437f-9789-0cffc372f104' and activeflag = 1;
