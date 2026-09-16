
-- Adoption Rate renew 3222595 - Datafix 01042020
-- Adoption case number: 3222595 

-- Before
select * from adoptioncaseagreementrate a 
where adoptionagreementrateid in ('69646a2d-d8aa-46db-af70-613af277c1d1','30f19ff4-588d-440d-965b-7565860b5b2c');

select * from adoptioncaserevision ar
where adoptionrevisionid in ('1a3b8c2a-cf71-4fc6-a710-a756fd2beba9','479821cd-aefc-49bb-86f7-a4245655b28f','c890a82f-18bc-4c8d-a1b9-65b688b906ef');

-- Update
update adoptioncaseagreementrate a 
set a.paymentamout = 571.25, a.updatedon = '2020-04-01 00:00:00'::date
where adoptionagreementrateid in ('69646a2d-d8aa-46db-af70-613af277c1d1','30f19ff4-588d-440d-965b-7565860b5b2c');

update adoptioncaserevision ar
set ar.paymentamt = 571.25, ar.updatedon = '2020-04-01 00:00:00'::date
where adoptionrevisionid in ('1a3b8c2a-cf71-4fc6-a710-a756fd2beba9','479821cd-aefc-49bb-86f7-a4245655b28f','c890a82f-18bc-4c8d-a1b9-65b688b906ef');


-- After
select * from adoptioncaseagreementrate a 
where adoptionagreementrateid in ('69646a2d-d8aa-46db-af70-613af277c1d1','30f19ff4-588d-440d-965b-7565860b5b2c');

select * from adoptioncaserevision ar
where adoptionrevisionid in ('1a3b8c2a-cf71-4fc6-a710-a756fd2beba9','479821cd-aefc-49bb-86f7-a4245655b28f','c890a82f-18bc-4c8d-a1b9-65b688b906ef');
