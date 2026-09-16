-- Adoption Rate renew 3053585 - Datafix 05032020
-- Adoption case number: 3053585 

-- Before
select * from adoptioncaseagreementrate a 
where adoptionagreementrateid in ('26644020-0bda-4d79-b08d-c082fd10f78d', '3984150a-4401-4c6e-aab0-95d28f1baa3c');

select * from adoptioncaserevision ar
where adoptionrevisionid in ('068f74b4-32aa-4886-84b8-6d1849fe69b1', '8fbc8304-fa41-4ba5-b299-ae071b2c36c8');

-- Update
update adoptioncaseagreementrate a 
set 
	a.startdate = '2020-02-03 10:00:00'::date, 
	a.updatedon = '2020-03-06 00:00:00'::date
where 
	adoptionagreementrateid in ('26644020-0bda-4d79-b08d-c082fd10f78d',
	'3984150a-4401-4c6e-aab0-95d28f1baa3c');

update adoptioncaserevision ar
set 
	ar.agreementstartdate = '2020-02-03 10:00:00'::date, 
	ar.approvaldate = '2020-03-06 00:00:00'::date, 
	ar.updatedon = '2020-03-06 00:00:00'::date
where 
	adoptionrevisionid in ('068f74b4-32aa-4886-84b8-6d1849fe69b1',
	'8fbc8304-fa41-4ba5-b299-ae071b2c36c8');


-- After
select * from adoptioncaseagreementrate a 
where adoptionagreementrateid in ('26644020-0bda-4d79-b08d-c082fd10f78d', '3984150a-4401-4c6e-aab0-95d28f1baa3c');

select * from adoptioncaserevision ar
where adoptionrevisionid in ('068f74b4-32aa-4886-84b8-6d1849fe69b1', '8fbc8304-fa41-4ba5-b299-ae071b2c36c8');