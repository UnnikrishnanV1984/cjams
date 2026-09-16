/*
Issue Description: There are two persons for the same individual but last names spelled different for Jayden. 
The last name Roseboro is spelled correctly. Rosedoro is incorrect. Can these two be merged or can Jayden Rosedoro be deleted?
Category/Module: Bug
Root cause: Due to data glitch caused to get records in intake ,and person,contact tab, user have access see the data , he do not have acces remove thos records.
Fix provided: DB queries  update peroson ,contactparticipants table.
Data/Code fix ticket#: CJAMS-57704
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update person 
set activeflag = 0, updatedby  = 'CJAMS-57704', updatedon = now()
where personid  = '369e5014-8f58-4eb9-a385-0635f7a1b9f9' and activeflag = 1;

--select  activeflag,* from contactparticipant where contactparticipantid = '671d06ac-8d70-40bc-b3eb-4070b4e1fbbf';-- //activeflag=0
update contactparticipant 
set activeflag = 0, updatedby  = 'CJAMS-57704', updatedon = now()
where contactparticipantid = '671d06ac-8d70-40bc-b3eb-4070b4e1fbbf'  and activeflag = 1;



UPDATE cjams.intakeservicerequestactor
SET updatedby='CJAMS-57704', updatedon=now(), activeflag = 0 
where intakeservicerequestactorid = '6210d29e-bc85-4e11-98d2-fbec5de7322b' and activeflag = 1;

UPDATE cjams.actor
SET updatedby='CJAMS-57704', updatedon=now(), activeflag = 0
where actorid = 'aadd1a67-3945-44a9-9a6a-4572ea7df579' and activeflag = 1;

update cjams.personrole  
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-57704'
where personroleid = '47194d13-a656-4cab-b0bd-73ba4e678f39' and activeflag = 1;

update cjams.actorrelationship  
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-57704'
where actorrelationshipid = '5d9a008e-3adf-41c4-be87-eba74f035791' and activeflag = 1;

update cjams.personroletype 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-57704'
where personroletypeid  = '655bfba3-b780-4f87-a461-454f0405e511' and activeflag = 1;



update actor
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-57704'
where actorid = 'd1781b62-f177-4b26-a7c0-3514508a428d' and activeflag = 1;

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-57704'
where intakeservicerequestactorid = '4c12409a-766a-4baa-a4ad-9e09ff8ed9e4' and activeflag = 1;