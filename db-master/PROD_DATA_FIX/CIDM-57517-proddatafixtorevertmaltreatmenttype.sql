/*
   Issue Description: CJAMS-57517
   Category/ Module  : Prod data fix to revert maltreament type
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update investigationallegation set allegationid = '627b574e-aa98-48c1-98c3-cf6f5d155eff', updatedby = 'CJAMS-57517', updatedon = now()
where investigationallegationid in ('01218781-42a4-40e1-be97-fb43a2d12421') and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';

update investigationallegationmaltreators set activeflag = 1, updatedby = 'CJAMS-57517', updatedon = now()
where investigationallegationmaltreatorsid = '3d3904bd-e13c-4362-b7e6-1c4af82f98d7' and activeflag = 0;


update investigationallegationmaltreators set activeflag = 0, updatedby = 'CJAMS-57517', updatedon = now()
where investigationallegationmaltreatorsid = '4485e12e-09fe-4632-bb95-f18a5b7bd463' and activeflag = 1;