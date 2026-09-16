/*
   Issue Description: CDM-24145
   Category/ Module  : Investigation Findings
   Root cause: CJAMS will not allow the worker to type in the Investigation Findings for any kind of finding (Ruled Out, Unsub or Indicated) for one of the alleged maltreators in the closed case.

   Reason why no related code fix: Worker needs to update/add the requested data. 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update 	investigationfinding
set 	activeflag = 0
where 	investigationfindingtypekey = 'RO' 
		and investigationallegationid = '239e8b7f-3d5c-44a4-b51d-fce3ec3b1665' 
		and personid = 'ba054601-6c91-40a0-afed-c469989c4087' 
		and activeflag = 1;

insert into  investigationfinding(investigationfindingtypekey, investigationallegationid, personid, activeflag, insertedby, insertedon, updatedby, updatedon, findingcomments, omissiondesc )
values('RO', '239e8b7f-3d5c-44a4-b51d-fce3ec3b1665', 'ba054601-6c91-40a0-afed-c469989c4087', 1, 'CDM-24145', now(), 'CDM-24145', now(), 'An act that involves sexual molestation or sexual exploitation (describe in detail): Paris disclosed that PopPop pulled her “diamond” and explained that her “diamond” was her vagina. However, Paris was not able to provide other details regarding the incident and it was determined that the allegation of child sexual abuse could not be determined if it was child maltreatment.', 'The act involving sexual molestation or exploitation was by a parent, caregiver, authority figure, or by a household or family member (insert name and whether the person is a parent, OR caregiver, OR authority figure, OR household OR family member): Mr. Larry Watkins is the paternal great grandfather of Paris');
