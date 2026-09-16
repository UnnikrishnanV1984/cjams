/*
Root cause: The review request is not available under the default supervisor
Fix provided:  Datafix done to show under supervisor case pending approval.
Data/Code fix ticket#: CJAMS-69350
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
*/


update routing
set activeflag = 0,updatedon = now(), updatedby = 'CJAMS-69350'
where objectid = '4a4e452b-a4b2-40f9-a4f0-fff899425417' and eventcode = 'GAAP'
    and routingstatustypeid = '17' and activeflag = 1 ;