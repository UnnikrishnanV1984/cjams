
/*
   Issue Description: CDM-15616
   Category/ Module  :  Case Removal Update
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-05-13 00:00:00	2021-05-10 00:00:00
update personprogramarea set startdate = '2021-05-05 13:00:00',enddate = '2021-05-05 13:01:00', updatedby ='CDM-15616', updatedon = now() where personprogramid = '083791f3-c415-4ac4-96b4-040155ed8b1b';

update personprogramarea set activeflag = 0, updatedby ='CDM-15616', updatedon = now() where personprogramid in ('a43c3d69-cdbf-465e-8fc7-e4c81cd1f469','84fb22d2-9e3e-4e7e-af7d-2ac90c13105e','baf447f2-8485-4b58-9e86-fc3dba3853df','2d493ffd-df96-42a5-aec7-0def9c1b95ee');