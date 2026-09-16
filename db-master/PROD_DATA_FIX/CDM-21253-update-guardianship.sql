/*
-- CDM-21253- 

-- Issue Description: 
 Unable to update the GAP Application
  
-- Customer Email ID: sandy.snow@maryland.gov

-- Root cause: Data fix to update the gap application screen
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update guardianship set iscgenteredagreement = true, documentsigned = true, isapprovedkinshipplacement = true, updatedby = 'CDM-21253', updatedon = now()  
where gapid in ('a095766e-1648-436b-a521-9d7c6a411b74', '763b482f-6a7e-4010-9b86-29b2385c927f','ec764418-c8a3-4161-bcc2-a566fd12b533');


-- 2021-12-01 05:00:00    2021-12-02 05:00:00    2021-12-02 05:00:00    2021-12-02 05:00:00
update gapapplication set planmeetingdate = '2021-10-01 05:00:00', ldssdirectordate = '2021-10-06 05:00:00', guardianonedate = '2021-10-01 05:00:00', guardiantwodate = '2021-10-01 05:00:00', updatedby = 'CDM-21253', updatedon = now() 
where gapid in ('a095766e-1648-436b-a521-9d7c6a411b74','ec764418-c8a3-4161-bcc2-a566fd12b533','763b482f-6a7e-4010-9b86-29b2385c927f');