/*
   Issue Description: CJAMS-59273
   Category/ Module  : duplicate AR case from same Intake
   Root cause: Data fix has been done to remove CPS-AR : 251023040564
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest
    set activeflag = 0,
        updatedby = 'CJAMS-59273',
        updatedon = now()
    where servicerequestnumber = '251023040564'
    and activeflag = 1;

update intakeservicerequestactor
    set activeflag = 0,
        updatedby = 'CJAMS-59273',
        updatedon = now()
    where intakeserviceid = '5dee639e-4de1-4bee-897b-37e6afbaabec'
    and activeflag = 1;

update actor
    set activeflag = 0,
        updatedby = 'CJAMS-59273',
        updatedon = now()
    where intakeserviceid = '5dee639e-4de1-4bee-897b-37e6afbaabec'
    and activeflag = 1;

update intakeservrequestsdmmaltreatment
    set activeflag=0,
        updatedby = 'CJAMS-59273',
        updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid = '5dee639e-4de1-4bee-897b-37e6afbaabec'
    and activeflag = 1)
    and activeflag = 1;


update intakeservicerequestsdm
    set activeflag = 0,
        updatedby = 'CJAMS-59273',
        updatedon = now()
    where intakeserviceid = '5dee639e-4de1-4bee-897b-37e6afbaabec'
    and activeflag = 1;
