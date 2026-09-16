/*
Issue Description: CJAMS-66163 Subsidy record deletion
Category/Module: GAP Subsidy
Root cause: User error,user requested to remove duplicate subsidy rate slab 
Fix provided: Data fix has been done to remove duplicate subsidy rate slab 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix to correct it.
*/


update gapagreementrate set activeflag=0,
updatedby='CJAMS-66163',updatedon=now() where gapagreementrateid='936792e3-62b8-4dff-9056-c94f075420e8' and activeflag =1;

update gapratesrevision  set activeflag=0,
updatedby='CJAMS-66163',updatedon=now() where gaprateid='936792e3-62b8-4dff-9056-c94f075420e8' and activeflag =1;

update routing set activeflag=0,
updatedby='CJAMS-66163',updatedon=now() where objectid='936792e3-62b8-4dff-9056-c94f075420e8'  and activeflag=1;