/*
   Issue Description: CJAMS-61437
   Category/ Module  :Assignments
   Root cause:User Request, I251013341104:This referral was transferred from Baltimore County; 
   however, the transfer is still showing Baltimore county but it was assigned to a screener in Baltimore City. The screener is not able to work in the referral. This case was transferred from Baltimore County.  
   Fix Provided: So made necessary data changes  and changed from baltimorecounty to baltimorecity
*/
UPDATE intakedastaging
SET 
  jsondata = jsonb_set(
    jsonb_set(
      jsondata::jsonb, 
      '{General,countyid}', 
      '"7665ca54-5374-4174-be07-a687b811a82c"'::jsonb
    ), 
    '{General,Author}', 
    '"Darlene Winder"'::jsonb
  )::jsonb,
    cruworkername = 'a1a0dd48-12f8-4fe0-8d17-15dae74fe2ca',--141e7c84-1e17-4ddd-a10a-b8072694bfbf
  updatedby = 'CJAMS-61437',
  updatedon = now()
WHERE intakenumber = 'I251013341104'
and activeflag=1;

UPDATE intakedastatus
SET 
  jsondata = jsonb_set(
    jsonb_set(
      jsondata::jsonb, 
      '{General,countyid}', 
      '"7665ca54-5374-4174-be07-a687b811a82c"'::jsonb
    ), 
    '{General,Author}', 
    '"Darlene Winder"'::jsonb
  )::jsonb,
  updatedby = 'CJAMS-61437',
  updatedon = now()
WHERE intakenumber = 'I251013341104'
and activeflag=1;
