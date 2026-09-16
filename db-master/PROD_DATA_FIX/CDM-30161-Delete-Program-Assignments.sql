/*
   Issue Description: CDM-30161
   Category/ Module  : program assignments
   Root cause: user requeseted to remove program assignments where the case was created in error  
   Pull request# for code fix: 8585
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/
update personprogramarea set activeflag = 0, updatedon = now(), updatedby = 'CDM-30161'
where personprogramid in ('aa15e4e1-2aa8-4bc8-a375-a7be26997ba5', 'f4cbb501-ed02-4a02-b5fc-8dd69a5c2e4e', '5fe24abd-3451-4cdc-9ffb-b1da19b3cd91', 
'4e2d22c6-a0c3-4471-a01b-e231b6bfcf60', '4676842f-ae3d-4e67-98aa-a9802368f1e7', '2efd99a6-8de4-45d1-b511-c153c30a13d5',
'e3cec51a-9bfd-4275-a5d1-517d99a63713', '8750f3d2-10dd-4844-be0b-529196601f8c');