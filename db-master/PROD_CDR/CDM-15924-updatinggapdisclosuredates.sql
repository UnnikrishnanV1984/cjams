/*
   Issue Description: CDM-15924
   Category/ Module  :  Updating Gap disclosure Date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/


UPDATE cjams.gapdisclosure
SET disclosuredate='2021-07-13 08:34:30.293', orientationmeetingdate = '2021-07-13 08:34:30.293', updatedon = now(),updatedby = 'CDM-15924'
WHERE gapid in ('755faa37-7d8f-4c09-a085-4434632bc22e','54b6a1c2-4f4f-403e-a09e-9b13dbc980bf');
