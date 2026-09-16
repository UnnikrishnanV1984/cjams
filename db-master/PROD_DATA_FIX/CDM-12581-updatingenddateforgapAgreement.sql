-- 2022-04-08 18:34:36
-- Enddate needs to be 365 days from the start date so updating the enddate for Gap agreement rate
update gapagreementrevision set enddate = '2021-11-15 18:34:36',updatedon = now(), updatedby = 'CDM-12581' 
where gapagreementid = 'af623f8a-8468-4380-b3a1-5e8b89960789';


update gapagreementrate set enddate = '2021-11-15 18:34:36',updatedon = now(), updatedby = 'CDM-12581'
where gapagreementrateid = '774ad30b-8a09-4a96-ae77-48513428b995';