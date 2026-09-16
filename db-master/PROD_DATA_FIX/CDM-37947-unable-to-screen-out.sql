/*
Issue Description: CDM-37947: 241030294793:This case was erroneously screened in. After review, it was determined that it needs to be screened out per UM Kima Jay-Armstrong.
Category/ Module: User Error
Root cause: I241012088713 - Intake (to be Screened-out) update comments
241030294793 - Delete Service Case
Fix provided :yes, write Db query
Code fix ticket#:CDM-37947
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Removed the case from servicecase
update servicecase
set
	activeflag = 0,
	updatedby = 'CDM-37947',
	updatedon = now()
	where servicecaseid = '385697f2-eca4-46e9-85b4-cfd40a2f0e46'
	and activeflag = 1;
	
--Removed the case from caseassignment
update caseassignment
set 
	activeflag = 0,
	updatedby = 'CDM-37947',
	updatedon = now()
	where objectid = '385697f2-eca4-46e9-85b4-cfd40a2f0e46'
	and activeflag = 1;
	
--Removed the case from servicecasedisposition
update servicecasedisposition
set 
	activeflag = 0,
	updatedby = 'CDM-37947',
	updatedon = now()
	where servicecaseid = '385697f2-eca4-46e9-85b4-cfd40a2f0e46'
	and activeflag = 1;
	
--Updated Status and Notes in intakedastaging
update intakedastaging
set 
	status = 'Closed',
	narrative = '<p>NOTE: Per Unit Manager Ms. Kima Armstrong, this case was re-routed to the active family preservation team, Taheesa Robinson and Tanya Keene (Case #  221030016828).  Stephen Williams is not the assigned caseworker for this family.  A duplicate service case was opened by Smita (extended hours supervisor) and during my discussion with Marjuin I was under the impression that Extended Hours was going to close out the duplicate service case.</p><p>Case Head: Sauda Ramadhan (DOB 01/01/1994)</p><p>Address: 5012 Denview Way</p><p>Apt. G.</p><p>Baltimore, Md. 21206</p><p>Telephone: 443 894-9169</p><p><br></p><p>Father: Akilil Habamungu (DOB 09/12/1988)</p><p>Address: Unknown</p><p>Telephone: Unknown</p><p><br></p><p>Children:  Ashura Ramadhan (DOB 03/19/2014) Victim Child</p><p>                Eca Ramadhan (DOB 06/11/2015)</p><p>                 Nyota Msabaha (DOB 01/01/2009)</p><p>               Junior Akili (DOB 10/11/2021)</p><p><br></p><p> THE FAMILY NEED AN INTERPRETER : (SWAHILI)</p><p><br></p><p>The caller is the Social Worker from St. Agnes Medical Center and she is reporting that Mother Sauda Ramadhan had a baby, Ashura Ramadhan on 03/19/2024.  The caller reported  that mother had a scheduled C- Section for 03/19/2024 and the baby was delivered at 39 weeks gestation and the baby is a healthy baby, no problems or concerns. </p><p>The caller reported that the hospital has a concern with the mothers interactions with the newborn baby. The caller reported that the baby is in the room with mother and she has not changed the babys pamper or fed the baby. The caller reported that the hospital staf has been caring for the baby.</p><p>The caller reported that the Fatjer Ak</p><p><br></p>',
	updatedby = 'CDM-37947',
	updatedon = now()
	where intakenumber = 'I241012088713'
	and activeflag = 1;
	
--Updated supDisposition to ScreenOUT in intakesnapshot
update intakesnapshot
set 
	jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}', jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"')))),
	updatedby = 'CDM-37947',
	updatedon = now()
	where intakenumber = 'I241012088713'
	and activeflag = 1;
	
--Updated supComments per instruction in intakesnapshot
update intakesnapshot
set 
	jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}', jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supComments}', '"Per Unit Manager Ms. Kima Armstrong, this case was re-routed to the active family preservation team, Taheesa Robinson and Tanya Keene (Case #  221030016828).  Stephen Williams is not the assigned caseworker for this family.  A duplicate service case was opened by Smita (extended hours supervisor) and during my discussion with Marjuin I was under the impression that Extended Hours was going to close out the duplicate service case."')))),
	updatedby = 'CDM-37947',
	updatedon = now()
	where intakenumber = 'I241012088713'
	and activeflag = 1;