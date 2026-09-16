/*
   Issue Description: CDM-44091,unable to have agreement approved - its stuck in review status.
   Category/ Module  : Application
   Root Cause: The worker who send for review was deactivated and even the default supervisor associated with that worker 
    was deactivated too, leading the review process hanging there without any supervisor assignment.
   Pull request# for code fix: 
   Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/
/*
select * from gapagreement where gapagreementid = '8364f598-933c-4bc8-a381-0b5429967a5a';
select insertedon,updatedon,activeflag,* from routing where objectid = '8364f598-933c-4bc8-a381-0b5429967a5a' and activeflag=1;
-- here gapagreementid is same as objid
--from : 96ba1f6c-c1bd-4213-92c2-0e62812330f0
--TO: aabfe50d-3996-444c-a2fb-4640f0ff257b
select supervisorid,* from userprofile where securityusersid = '96ba1f6c-c1bd-4213-92c2-0e62812330f0'
select * from userprofile where securityusersid = 'aabfe50d-3996-444c-a2fb-4640f0ff257b'
*/
update routing
set toroleid='CWSP', 
	fromsecurityusersid = '96ba1f6c-c1bd-4213-92c2-0e62812330f0', --PamelaPrice	
	tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', --AmberWebster
	updatedby='CDM-44091', updatedon = now()
where objectid='8364f598-933c-4bc8-a381-0b5429967a5a' and activeflag = 1;
