/*
Issue Description: CJAMS-65952 Subsidy record deletion
Category/Module: GAP Subsidy
Root cause: User error,user requested to remove  subsidy rate slab 
Fix provided: Data fix has been done to remove  subsidy rate slab 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix to correct it.
*/




update gapagreementrate set activeflag=0,
updatedby='CJAMS-65952',updatedon=now() where gapagreementrateid in ('22560a21-9cdc-4dd3-af01-4cc81f33f71e','46b4e0f5-a7f0-405c-9134-62760827aa72') and activeflag =1;

update gapratesrevision  set activeflag=0,
updatedby='CJAMS-65952',updatedon=now() where gaprateid in ('22560a21-9cdc-4dd3-af01-4cc81f33f71e','46b4e0f5-a7f0-405c-9134-62760827aa72') and activeflag =1;

update routing set activeflag=0,
updatedby='CJAMS-65952',updatedon=now() where objectid in ('22560a21-9cdc-4dd3-af01-4cc81f33f71e','46b4e0f5-a7f0-405c-9134-62760827aa72')  and activeflag=1;
