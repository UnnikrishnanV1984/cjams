/*
Issue Description: 251023064969:NYIARA K FREEMAN should be a named maltreater due to the following factors. 
The alleged maltreators use of coercion, cruelty, violence, or lack of regard for the safety or welfare of the 
alleged victim;The likelihood of the alleged maltreator committing further child abuse or neglect; andThe availability and likely success of services to minimize the risk of future maltreatment.
Category/Module: Error
Root cause: User Error
Fix provided: DB queries to 
    1. Remove the Unnamed minor person card
    2. Uncheck the Maltreatment Allegation is not applicable for NYIARA K FREEMAN (PID# 2361923) then add the entered unnamed maltreatment allegation information to NYIARA K FREEMAN then remove the Maltreatment Allegation record for Unnamed Minor.
    3. Add the Investigation Findings for NYIARA K FREEMAN (PID# 2361923) and add the the entered unnamed investigation findings information.
    4. Remove Contact ID: 15081589

Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
/*
 * Name: Unnamed minor
 * CJAMSPID: 204157508
 *Remove person
 */

/*
select * from person where cjamspid = '204157508';--c4ee4339-98d6-4102-abd5-b3763ddfc42f
select * from intakeservicerequestactor where personid = 'c4ee4339-98d6-4102-abd5-b3763ddfc42f'
and intakeserviceid = '7bbaf84a-6616-434e-b9ec-75c82f95c56a';
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-60347', updatedon = now()
where personid ='c4ee4339-98d6-4102-abd5-b3763ddfc42f' 
and intakeserviceid ='7bbaf84a-6616-434e-b9ec-75c82f95c56a' 
and activeflag = 1;

update  personroletype
set activeflag = 0,updatedby = 'CJAMS-60347',
	updatedon = now()
where activeflag = 1
and personroleid
in (select personroleid
from personrole
where intakeserviceid = '7bbaf84a-6616-434e-b9ec-75c82f95c56a'
and personid ='c4ee4339-98d6-4102-abd5-b3763ddfc42f'
and activeflag = 1
);
--personrole
update personrole
set activeflag = 0,	updatedby = 'CJAMS-60347', updatedon = now()
where intakeserviceid = '7bbaf84a-6616-434e-b9ec-75c82f95c56a' and personid ='c4ee4339-98d6-4102-abd5-b3763ddfc42f' and activeflag = 1 ;
    
update actor
set activeflag = 0,	updatedby = 'CJAMS-60347', updatedon = now()
   where intakeserviceid = '7bbaf84a-6616-434e-b9ec-75c82f95c56a' and personid ='c4ee4339-98d6-4102-abd5-b3763ddfc42f'
and activeflag = 1;

update actorrelationship
set activeflag = 0,	updatedby = 'CJAMS-60347', updatedon = now()
where intakeservicerequestactorid in ('3c30a6b7-e7b9-42f2-89b5-b709807f77ef','ecb33f3c-603a-4f43-95b2-4ac47f9f91ed') and activeflag = 1;

/*
 * contactid: 15081589
 *Remove contact notes record
 */

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CJAMS-60347' , updatedon = now()
WHERE progressnoteid = '1ad14a96-b379-41b8-ace2-6fc787001e33' and activeflag=1;

update progressnotedetail set activeflag = 0, updatedby = 'CJAMS-60347' , updatedon = now()
WHERE progressnoteid ='1ad14a96-b379-41b8-ace2-6fc787001e33' and activeflag=1;

update contactparticipant
SET activeflag = 0, updatedby = 'CJAMS-60347' , updatedon = now()
WHERE progressnoteid = '1ad14a96-b379-41b8-ace2-6fc787001e33' and activeflag = 1;

/*
 * update the maltreatement alligation
select ischildfatality,activeflag,* from investigationallegation where investigationallegationid = '6d59d65f-e24a-4bf6-9c92-052b16e1a5ed' and activeflag = 1;

investigationid and alligationid 
a04cba78-03ac-4100-b3e2-1c6812596d7f	e11fc4b5-1edf-4f17-af54-b536bbf6df31
select isnotapplicable,* from investigationmaltreatment where investigationid = 'a04cba78-03ac-4100-b3e2-1c6812596d7f' and activeflag=1;
*/

update investigationmaltreatment
set isnotapplicable = 0,
	updatedby = 'CJAMS-60347',
	updatedon = now()
where investigationid = 'a04cba78-03ac-4100-b3e2-1c6812596d7f' 
	and activeflag=1
	and maltreatmentid = '23031960-4a77-4941-baab-75c5923b1e22';
	

update investigationallegation
set ischildfatality = 0,
	updatedby = 'CJAMS-60347',
	updatedon = now()
where investigationid = 'a04cba78-03ac-4100-b3e2-1c6812596d7f' 
	and activeflag=1
	and investigationallegationid = '6d59d65f-e24a-4bf6-9c92-052b16e1a5ed';
	
/*
 * 
 *update the investigation finding
 */

/*
 * select * from investigationallegation where maltreatmentid = '80d437cc-ae0f-4014-8cae-59dbc976553c';--invallID: c62e0309-ebcf-4d8d-9217-e717e7fbf5ee
select investigationfindingtypekey,findingcomments,harmdesc,omissiondesc,* from investigationfinding 
where investigationallegationid in ('6d59d65f-e24a-4bf6-9c92-052b16e1a5ed',
'c62e0309-ebcf-4d8d-9217-e717e7fbf5ee') and activeflag=1;
*/

update investigationfinding
set investigationallegationid = '6d59d65f-e24a-4bf6-9c92-052b16e1a5ed',--c62e0309-ebcf-4d8d-9217-e717e7fbf5ee
	updatedby = 'CJAMS-60347',
	updatedon = now()
where investigationfindingid = '9bf685de-b20c-4736-af72-a5832f733c8a'
and investigationallegationid = 'c62e0309-ebcf-4d8d-9217-e717e7fbf5ee';