/*
   Issue Description: CJAMS-68440
   Category/ Module  : 
   Root cause: While analyzing we found that there are 3 Neglect findings available in the Investigation Findings screen while there is only one Neglect Maltreatment Allegation record.

Please proceed with the data fix to remove the duplicate Neglect Findings as highlighted below.
   Fix Provided: Data fix has been done to remove the incorrect maltreator from the investigation findings table.
   Data/Code fix ticket#: CJAMS-68440
   Regression Impacts: N/A
   Is Code fix Required?: 
   Code fix ticket#: N/
*/


update investigationallegation
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68440' 
where investigationallegationid in ('abe3b4b1-acd8-4c04-8b69-92126f1a71c0', 'db25622a-5e6d-4b39-a753-251f18fe52b2') and activeflag = 1;


update investigationallegationmaltreators 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-68440' 
where investigationallegationid in ('abe3b4b1-acd8-4c04-8b69-92126f1a71c0', 'db25622a-5e6d-4b39-a753-251f18fe52b2') and activeflag = 1;
