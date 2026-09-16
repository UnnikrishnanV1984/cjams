/*
   Issue Description: CDM-16837
   Category/ Module  : Service case  
   Root cause: User wants to convert the serivce request into service case#
   Pull request# for code fix: 4558
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

insert into caseassignment
(eventidno_fk,eventdttmkey_fk,fromworkeridno,fromsupervisoridno,fromofficecode,toworkeridno,tosupervisoridno,toofficecode,caseassigncode,effectivedate,effectivetime,frombizunitidno,tobizunitidno,old_id,foldergroupindc,cmfldrgrpasgnkey,insertedby,updatedby,insertedon,updatedon,objecttypekey,objectid,responsibilitytypekey,activeflag,startdate,enddate,fromteamid,toteamid,remarks,statustypekey,fromldssid,toldssid,assignmenttype,fk_id,assigndate,isrestricted,assigndescription,summary,isnew,expungementflag,entityopendate,etl_userid,etl_load_date,servicetype)
select eventidno_fk,eventdttmkey_fk,fromworkeridno,fromsupervisoridno,fromofficecode,toworkeridno,tosupervisoridno,toofficecode,caseassigncode,effectivedate,effectivetime,frombizunitidno,tobizunitidno,old_id,foldergroupindc,cmfldrgrpasgnkey,
'CDM-16837','CDM-16837',now(),now(),
'servicecase',(select servicecaseid from intakeservicerequest i where intakeserviceid = '9aa17937-0e9c-4438-b1d2-10e99d0e209a' and activeflag = 1 limit 1),
responsibilitytypekey,activeflag,startdate,enddate,fromteamid,toteamid,remarks,statustypekey,fromldssid,toldssid,assignmenttype,fk_id,assigndate,isrestricted,assigndescription,summary,isnew,expungementflag,entityopendate,etl_userid,etl_load_date,servicetype
from caseassignment where objectid = '9aa17937-0e9c-4438-b1d2-10e99d0e209a' and activeflag = 1 and enddate is null ;