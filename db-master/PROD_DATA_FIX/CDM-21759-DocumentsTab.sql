/*
   Issue Description: CDM-21759
   Category/ Module  : Documents tab
   Root cause: user wants toremove unwanted docs
   Pull request# for code fix: 5607
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update documentproperties set activeflag = 0, updatedby = 'CDM-21759', 
updatedon = now() where documentpropertiesid in ('e72acfec-ffc5-41bd-9e24-51b8fc211162', '94a7a7a3-84e3-4928-972b-1392a4172001');

update documentattachment set activeflag = 0, updatedby = 'CDM-21759', 
updatedon = now() where documentpropertiesid in ('e72acfec-ffc5-41bd-9e24-51b8fc211162', '94a7a7a3-84e3-4928-972b-1392a4172001');