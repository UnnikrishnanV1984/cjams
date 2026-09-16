/*
   Issue Description: CJAMS-59346
   Category/ Module  : duplicate AR case from same Intake
   Root cause: Data fix has been done to remove CPS-AR : I251013274346 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest
    set activeflag = 0,
        updatedby = 'CJAMS-59346',
        updatedon = now()
    where servicerequestnumber = '251023044620'
    and activeflag = 1;

update intakeservicerequestactor
    set activeflag = 0,
        updatedby = 'CJAMS-59346',
        updatedon = now()
    where intakeserviceid = '54bd48e8-62f2-4b46-957a-5d025194341a'
    and activeflag = 1;

update actor
    set activeflag = 0,
        updatedby = 'CJAMS-59346',
        updatedon = now()
    where intakeserviceid = '54bd48e8-62f2-4b46-957a-5d025194341a'
    and activeflag = 1;

update intakeservrequestsdmmaltreatment
    set activeflag=0,
        updatedby = 'CJAMS-59346',
        updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid = '54bd48e8-62f2-4b46-957a-5d025194341a'
    and activeflag = 1)
    and activeflag = 1;


update intakeservicerequestsdm
    set activeflag = 0,
        updatedby = 'CJAMS-59346',
        updatedon = now()
    where intakeserviceid = '54bd48e8-62f2-4b46-957a-5d025194341a'
    and activeflag = 1;   

    update personprogramarea
    set activeflag = 0,
        updatedby = 'CJAMS-59346',
        updatedon = now()
    where personid ='01cdd8e4-abcc-4d8a-8805-091b06887b14' 
    and objectid = '54bd48e8-62f2-4b46-957a-5d025194341a'
    and activeflag = 1;