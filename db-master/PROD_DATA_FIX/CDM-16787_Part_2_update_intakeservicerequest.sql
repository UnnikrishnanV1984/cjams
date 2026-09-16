/*
    Issue no : CDM-16787
    Issue desc : Service case not created and linked for ROH-CPS intake after approved
    Root cause : Unknown. Creating a data fix to link a new service 
*/

update intakeservicerequest 
set activeflag = 1, servicerequestnumber = (select sc.servicecasenumber from servicecase sc where sc.servicecaseid = (select servicecaseid from intakeservicerequest i  where intakeserviceid = '8f96a564-2fcf-4d83-9bca-bdc83ee8296a')), updatedon = now(), updatedby = 'CDM-16787' 
where intakeserviceid = '8f96a564-2fcf-4d83-9bca-bdc83ee8296a';
