
update cjams.actor 
set
personid = 'e9136dc5-cff1-4e0b-8532-9f02a61401f3',
updatedon = now(),
updatedby = 'CDM-17522'
where actorid = '742d219b-443e-42b9-ad13-0d76cb617ed0';


update cjams.intakeservicerequestactor i 
set
personid = 'e9136dc5-cff1-4e0b-8532-9f02a61401f3',
updatedon = now(),
updatedby = 'CDM-17522'
where intakeservicerequestactorid in ('a78bd069-6223-4cd7-adfa-5537594b7747', 'b77e5447-0127-4691-b382-02fdea2e39c6');

update cjams.personrole p  
set
personid = 'e9136dc5-cff1-4e0b-8532-9f02a61401f3',
updatedon = now(),
updatedby = 'CDM-17522'
where personroleid = 'aec35ed7-bdab-4584-9fcd-dc7dded7ed27';

update cjams.actorrelationship a2 
set
person1id = 'e9136dc5-cff1-4e0b-8532-9f02a61401f3',
updatedon = now(),
updatedby = 'CDM-17522'
where actorrelationshipid in ('e2931789-6045-48c9-9ce1-176ffbab3d81',
'3af39d88-d01d-4145-af61-96a1c76d8519', '517192ea-8050-45fe-9d01-b5915c9b3e7c', '74e09614-0cfb-4199-8cf7-3c9159e63c65');


update cjams.actorrelationship a2 
set
person2id = 'e9136dc5-cff1-4e0b-8532-9f02a61401f3',
updatedon = now(),
updatedby = 'CDM-17522'
where actorrelationshipid in ('20d2efd2-0249-46e7-aa20-064819470a1f', '8d390f41-4828-45cf-9133-aa4147d211f6',
'bfcc6f88-4cc5-4246-80cd-64d3c5995283', 'bad99c79-b1df-4e06-8c56-a61fbfd8c190');
