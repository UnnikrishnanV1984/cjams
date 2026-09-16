/*
Issue Description:251023067090:We would like to end-date Asher Gossin, Ethan Gossin and Elijah Gossin. They were added to the active others tab by another jurisdiction. The other jurisdiction is unable to end-date them as well. The end-date should be 7/12/2025 or the closest possible date to 7/12/ 2025.
Root cause: User request to delete wrong clients in this case, due to they do not have access to delete.
Fix provided: DB query to udate actor etc.
Data/Code fix ticket#:CJAMS-60866
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update actor 
set activeflag  =0,updatedby  = 'CJAMS-60866',updatedon  = now()
where actorid  in ('95d1f46b-da95-4166-8d94-d0b659ae41cd',
'803979ef-944d-4af5-9195-8e7b58d246e9',
'12030d21-5b6c-4c06-b932-8451a38f66de') and activeflag =1;

update intakeservicerequestactor 
set activeflag  =0,updatedby  = 'CJAMS-60866',updatedon  = now()
where intakeservicerequestactorid  in (
'840068d7-08b5-499b-8857-78a552959f52',
'9e51a757-3261-4d59-8a99-afa1addcdf46',
'eabdee0b-0a10-42d6-b7b4-80e9f0f2fd62') and activeflag =1;


update personrole 
set activeflag  =0,updatedby  = 'CJAMS-60866',updatedon  = now()
where personroleid  in (
'55d4b909-53b1-4c34-9011-c24bd9d5e993',
'90f5d5bf-a3b8-4c95-8d22-2041d25dabb4',
'c3e3dd66-57df-4575-986d-01e3da04c275') and activeflag =1;


update personroletype 
set activeflag  =0,updatedby  = 'CJAMS-60866',updatedon  = now()
where personroletypeid  in (
'256265e3-04df-4fa8-adb7-6bdd177cf8c7',
'0e92f8ca-8466-4cfd-b3f6-5d9f22f5dfd1',
'e78221a9-5526-4cd0-9cf0-3c8840570aec') and activeflag =1;

update personprogramarea  
set activeflag  =0,updatedby  = 'CJAMS-60866',updatedon  = now()
where personprogramid  in (
'e21351cd-1342-4b46-883f-710fda25fcf3',
'00ac20fb-08b1-4971-b4d9-c08da2e095b2',
'f2752b76-d2c8-4113-84ed-98995a40f034') and activeflag =1;



update actorrelationship
set activeflag  =0,updatedby  = 'CJAMS-60866',updatedon  = now()
where actorrelationshipid  in (
'3a4b78a8-62d8-488f-947f-1a4ad553c215',
'4258262e-29bc-4c71-b273-06e33d770717',
'8acfacf5-b88d-4c60-a25a-3db356b894a2',
'cc1141d2-7785-4ae6-8a05-ae3d2e1a2511',
'6ba4f2ba-3172-4998-ac69-177ed4d82a02',
'64fa7972-c280-4d86-9212-6c0362c1a855') and activeflag =1;
