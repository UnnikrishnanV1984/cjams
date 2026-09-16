-- CDM-33182 - CLONE - Change Adoption Name - Missing Substance Class
/*
-- Issue Description: 
   Data fix to update the missing Substance Class info for Adoption clients 

-- Category/ Module: Case Management
-- Root cause: CJAMS is having flaw in code, the Substance Class info is not getting copied to Adoption clients while adoption case creation 
-- Fix Provided: Code fix has been provided to copy the Substance Class info to Adoption clients while adoption case creation. 
-- 				 Datafix has been provided to update the Substance Class info for Adoption clients based on the Bio client information.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-- Adoption Clients
select cjamspid,substanceexposednewbornflag, 
	substanceclasses, othersubstances, senstatusflag,
	substanceexposednewbornsourceid, substanceexposednewbornsourcetypekey, substanceexposednewborntimetamp,
	updatedby, updatedon
from person
where cjamspid in ( 200974727, 201288869, 201352883, 201403194, 201182746, 201400220, 
					201262221, 200985556, 201066458, 201066495, 201265867, 201284227, 
					201034103, 201398211, 201187904, 201253990 
				   )
	and activeflag = 1;

	
update cjams.person 
	set substanceclasses = '["BBS","BCOC","OPIA"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 200974727 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BCOC","BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201288869 
	and activeflag = 1 ;

update cjams.person
set substanceclasses = '["BMJA"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201352883
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BHOI","BMJA","BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201403194 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201182746 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201400220 and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BMJA","BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201262221 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 200985556 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BBS"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201066458 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BBS"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201066495 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["OPIA"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201265867
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BCOC","BOTH"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201284227 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BAS"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201034103 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BMJA","BENZO"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201398211 
	and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["OPIA"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201187904 
and activeflag = 1 ;

update cjams.person 
	set substanceclasses = '["BMTD"]', senstatusflag = 0, updatedby = 'CDM-33182', updatedon = now() 
where cjamspid = 201253990 
	and activeflag = 1 ;

-- After 
select cjamspid,substanceexposednewbornflag, 
	substanceclasses, othersubstances, senstatusflag,
	substanceexposednewbornsourceid, substanceexposednewbornsourcetypekey, substanceexposednewborntimetamp,
	updatedby, updatedon
from person
where cjamspid in ( 200974727, 201288869, 201352883, 201403194, 201182746, 201400220, 
					201262221, 200985556, 201066458, 201066495, 201265867, 201284227, 
					201034103, 201398211, 201187904, 201253990 
				   )
	and activeflag = 1;