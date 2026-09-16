/*
   Issue Description: CIDM-10724
   Category/ Module  : Prod data fix to update inactive legislative records so primary key can be added.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

ALTER TABLE legislative ADD CONSTRAINT legislative_pkey PRIMARY KEY (legislativeid);