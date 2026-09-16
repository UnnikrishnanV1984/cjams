/*
   Issue Description: CDM-15156
   Category/ Module  : Create Service case for Intake #I211010174757 and #I211010174065
   Root cause: User requested to create a new service case linked to existing intake request.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select * from cjams.createservicecase('41135a0e-4e4b-4449-bf6d-a8d6f578a095', null, 1, '0f8fbcb4-bc95-4005-9c54-4747eb2dc6b6', 'intake', '');
select * from cjams.createservicecase('c02460e8-2a5a-484d-95e9-da41abe8910d', null, 1, '0f8fbcb4-bc95-4005-9c54-4747eb2dc6b6', 'intake', '');