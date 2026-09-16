update intakeservreqchildremoval
set exitdate = '2020-05-12 10:00:00', returntime = '2020-05-12 10:00:00', removalexitreason = 'REUNIF', updatedon = now(), updatedby = 'Datafix user as per CDM-1721'
where intakeservreqchildremovalid = 'a64329ba-89ff-45f3-90c2-0257dfa2da68';

update intakeservreqchildremoval
set exitdate = '2020-05-12 10:00:00', returntime = '2020-05-12 10:00:00', removalexitreason = 'REUNIF', updatedon = now(), updatedby = 'Datafix user as per CDM-1723'
where intakeservreqchildremovalid in ('2e47a631-5925-43dc-9f8b-22a3897c7473','920df0df-32ce-4950-945b-b154c634f013');
