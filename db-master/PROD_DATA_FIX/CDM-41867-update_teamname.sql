/*
   Issue Description: CDM-41867
   Category/ Module  : Assignments
   Root cause: Cecil County worker Miriam Alvarez has moved from In Home Unit 8 to OHP Unit 3
    the change was complete in Sailpoint, it is not reflected in CJAMS under the workload tab.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select * from v_userprofile vu where securityusersid = '6d2a147a-aee5-4bf7-b58d-8a0d56f7d679'; 
--supervisorid: dc7166df-699d-4c20-a8a8-c8e00fb6866d, teammemberid: bc88cd33-6ac2-464b-8cc3-7513ccd5f5bc
from:
select teamname, teamnumber,teamid,countyid, * from team t where teamid = '0a7d6537-7d36-4436-967d-8eba17ed077b';
--In Home Unit #8	1434_16	0a7d6537-7d36-4436-967d-8eba17ed077b	817e0751-1fa8-4c31-8233-8fffd6426235	
to:
select teamname, teamnumber,teamid,countyid, * from team where teamname = 'OHP Unit #3';
--OHP Unit #3	1434_7	8ec81864-e227-4763-8927-3da344eeeee9	817e0751-1fa8-4c31-8233-8fffd6426235	

select * from teammember t where activeflag = 1 and teammemberid = 'bc88cd33-6ac2-464b-8cc3-7513ccd5f5bc';
*/
update teammember 
set 
teamid = '8ec81864-e227-4763-8927-3da344eeeee9',
updatedby = 'CDM-41867',
updatedon = now()
where teamid = '0a7d6537-7d36-4436-967d-8eba17ed077b' 
and activeflag = 1 
and teammemberid = 'bc88cd33-6ac2-464b-8cc3-7513ccd5f5bc';
 
