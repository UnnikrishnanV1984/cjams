/*
    Issue no : CDM-15874
    Issue desc : Service case not created and linked for ROH-CPS intake after approved
    Root cause : Unknown. Creating a data fix to link a new service 
*/

update intakeservicerequest 
set activeflag = 1, servicerequestnumber = (select sc.servicecasenumber from servicecase sc where sc.servicecaseid = (select servicecaseid from intakeservicerequest i  where intakeserviceid = 'f4e7d4cb-0912-4251-829b-5ac049282a96')), updatedon = now(), updatedby = 'CDM-15874' 
where intakeserviceid = 'f4e7d4cb-0912-4251-829b-5ac049282a96';