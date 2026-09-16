-- CDM-35648 - How to edit this field
/* Issue Description:User relation ship not matched in Title IV-E 

--PersonId: 201661174
--RemovalId: 285066

-- Category/ Module: Title IV-E 

-- Root cause: User relation ship not matched in Title IV-E
-- Fix Provided: Datafix has been provided to update relationship for person #201661174
-- Pull request# N/A

*/

select * from actorrelationship where person2id = '6793b267-42ac-4a33-812c-f76fee6d10e5' AND person1id = '3a8ba2af-db92-4dcd-8a2f-6fe19c398c1a' ORDER BY updatedon desc LIMIT 1;

update actorrelationship
set relationshiptypekey='BGFTHR' ,
	updatedon = now(), 	
	updatedby = 'CDM-35648'
where person2id = '6793b267-42ac-4a33-812c-f76fee6d10e5' and person1id = '3a8ba2af-db92-4dcd-8a2f-6fe19c398c1a' and actorrelationshipid='b944c339-3ba5-4a05-9490-0163d82592d7';
