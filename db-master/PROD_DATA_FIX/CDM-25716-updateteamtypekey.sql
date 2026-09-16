/*
  Issue Description: CDM-25716 Intake
   Category/ Module  :  user management
   Root cause: Incorrect team in the teammember table and the incorrect teamtypekey and supervisors in userprofile
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

--old team : 8ef1f01c-c6e2-4887-ab89-b796c17a19de
update teammember 
set teamid = 'd5abb69f-8086-4645-bb56-5ef8825d412d', updatedon = now(), updatedby = 'CDM-25716'
where teammemberid = 'b2ce8e74-d35e-4c31-b8b6-bad1018bb982' and activeflag =1;

--old supervisor :e2ad94e9-21df-418f-b1cb-ee4009ff45d2, old teamtypekey :ASPROV
update userprofile 
set teamtypekey ='CW',supervisorid='95b57433-f7c8-4735-86af-87f726510a59',assupervisorid='44517bfd-6b85-42c3-9fd1-f96a4cbe1a50', updatedon = now(), updatedby ='CDM-25716'
where email = 'christine.devlin@maryland.gov';