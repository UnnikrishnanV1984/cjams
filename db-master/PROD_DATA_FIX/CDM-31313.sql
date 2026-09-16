/*
 * CDM-31313 - Contact notes in the wrong Brittany Corbin case
 * Customer Email ID:janice.cavanaugh@maryland.gov
 * Customer Name:Janice Cavanaugh
 * Focus Area:Contact Notes
 * Description - 3303475:There are two Brittany Corbin's in CJAMS with similar dates of birth. 
 * Worker Linsey's case was originally opened for the wrong Brittany Corbin. Worker Linsey was made aware of this after she had put in case notes. 
 * Please delete case notes for this case 3003475 (Corbin 4/18/92) for the entry dates of 3/28/22-3/31/22. 
 * These entries were all made by Jennifer Linsey. Although we were notified this was either fixed or there were two tickets we need this 100 percent 
 * fixed asap given the sensitive nature of this situation.
 * In case 3303475, there is a person named "remove person". Please remove that person from the case. As well as Matthew Hudson (4178490) 
 * and Maverick Hudson (200889247). Please remove any contact notes and documents on or after 3/28/2022. Also please delete intake I221010258213.
 *
 */

select * from cjams.person where cjamspid='200889242';

-- Delete Program Assignment(s)
select  * 
	from personprogramarea
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
	and objectid = 'eece9657a-3bbf-4af4-9ed6-f9400c3f1ac1' 
	and activeflag = 1 ;


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
	and objectid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1' 
	and activeflag = 1 ;
	
-- Delete Person Role(s)
select servicecaseid, *
	from personrole
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
	and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
	and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;
	
-- Delete Person Relationship(s)
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
			and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select *
	from intakeservicerequestactor
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
	and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
	and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

-- Delete Actor
select *
	from actor
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

-- Update personroletype
select * from personroletype where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1');
		
		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-31313',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1');
		
-- Contact notes
update progressnote
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4' 
			) 
and activeflag = 1;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4' 
			) 
and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4' 
			) 
and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '3fad6a14-8edd-4442-8cf4-6cb091b9e6a4' 
			) 
and activeflag = 1 ; 

select intakeserviceid, * from intakeservicerequest where intakenumber = 'I221010258213';
select * from cjams.person where cjamspid='4178490';

-- Delete Program Assignment(s)
select  * 
	from personprogramarea
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
	and objectid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1' 
	and activeflag = 1 ;


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
	and objectid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1' 
	and activeflag = 1 ;
	
-- Delete Person Role(s)
select servicecaseid, *
	from personrole
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
	and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
	and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;
	
-- Delete Person Relationship(s)
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
			and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select *
	from intakeservicerequestactor
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
	and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
	and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

-- Delete Actor
select *
	from actor
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

-- Update personroletype
select * from personroletype where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1');
		
		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-31313',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1');
		
-- Contact notes
update progressnote
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'a9e8c023-fddd-4bf2-bb69-a97c6c48043c' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ; 

select intakeserviceid, * from intakeservicerequest where intakenumber = 'I221010258213';
select * from cjams.person where cjamspid='200889247';

-- Delete Program Assignment(s)
select  * 
	from personprogramarea
where personid = '30910d28-5034-4373-bbe1-285827407762'
	and objectid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1' 
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '30910d28-5034-4373-bbe1-285827407762'
	and objectid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1' 
	and activeflag = 1 ;
	
-- Delete Person Role(s)
select servicecaseid, *
	from personrole
where personid = '30910d28-5034-4373-bbe1-285827407762'
	and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '30910d28-5034-4373-bbe1-285827407762'
	and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;
	
-- Delete Person Relationship(s)
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '30910d28-5034-4373-bbe1-285827407762'
			and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid = '30910d28-5034-4373-bbe1-285827407762'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select *
	from intakeservicerequestactor
where personid = '30910d28-5034-4373-bbe1-285827407762'
	and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '30910d28-5034-4373-bbe1-285827407762'
	and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

-- Delete Actor
select *
	from actor
where personid = '30910d28-5034-4373-bbe1-285827407762'
and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where personid = '30910d28-5034-4373-bbe1-285827407762'
and intakeserviceid  = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1'
	and activeflag = 1 ;

-- Update personroletype
select * from personroletype where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '30910d28-5034-4373-bbe1-285827407762'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1');
		
		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-31313',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '30910d28-5034-4373-bbe1-285827407762'
			and intakeserviceid = 'ece9657a-3bbf-4af4-9ed6-f9400c3f1ac1');
		
-- Contact notes
update progressnote
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '30910d28-5034-4373-bbe1-285827407762' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '30910d28-5034-4373-bbe1-285827407762' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '30910d28-5034-4373-bbe1-285827407762' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = '30910d28-5034-4373-bbe1-285827407762' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;  

update progressnote
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'cac9e1d1-024e-446e-b11a-fbf5e36d3120' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'cac9e1d1-024e-446e-b11a-fbf5e36d3120' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'cac9e1d1-024e-446e-b11a-fbf5e36d3120' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid in (select distinct p.progressnoteid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
			where insr2.personid = 'cac9e1d1-024e-446e-b11a-fbf5e36d3120' and p.contactdate >= '3/28/2022' 
			) 
and activeflag = 1 ; 

update progressnote
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid = 'a3ad4588-492b-460e-8f4c-67131c4af36c' 
and activeflag = 1;

update progressnotedetail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid = 'a3ad4588-492b-460e-8f4c-67131c4af36c' 
and activeflag = 1 ;

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid = 'a3ad4588-492b-460e-8f4c-67131c4af36c' 
and activeflag = 1 ;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CDM-31313',
	updatedon = now()
where progressnoteid = 'a3ad4588-492b-460e-8f4c-67131c4af36c' 
and activeflag = 1 ; 

-- Delete Intake Number: I221010258213
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I221010258213') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31313'
where objectid in ('I221010258213') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I221010258213') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31313'
where intakenumber in ('I221010258213') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I221010258213') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31313'
where intakenumber in ('I221010258213') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I221010258213') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-31313'
where intakenumber in ('I221010258213') 
	and activeflag = 1 ;
	