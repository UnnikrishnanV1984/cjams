/*
   Issue Description: CDM-20448
   Category/ Module : Person Program Area
   Root Cause:	User Requested to update sub program area to FPS -  Family Preservation Services.
   
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--James Williams
select activeflag, programkey, subprogramkey, * from personprogramarea where personprogramid = 'cd221e9c-8dba-4f5a-9d5a-fd347b92df0d';

update 	personprogramarea
set 	subprogramkey = 'FPS', updatedby = 'CDM-20448', updatedon = now()
where 	personprogramid = 'cd221e9c-8dba-4f5a-9d5a-fd347b92df0d';

--Te'Amo Monsky
select activeflag, programkey, subprogramkey, * from personprogramarea where personprogramid = 'f8aaf899-a928-46c5-bc37-caa2f3dfb529';

update 	personprogramarea
set 	subprogramkey = 'FPS', updatedby = 'CDM-20448', updatedon = now()
where 	personprogramid = 'f8aaf899-a928-46c5-bc37-caa2f3dfb529';

--Makhi Sebro
select activeflag, programkey, subprogramkey, * from personprogramarea where personprogramid = '3768da00-58c5-4702-8b2f-17d8da350d8d';

update 	personprogramarea
set 	subprogramkey = 'FPS', updatedby = 'CDM-20448', updatedon = now()
where 	personprogramid = '3768da00-58c5-4702-8b2f-17d8da350d8d';

--Nayely Sebro
select activeflag, programkey, subprogramkey, * from personprogramarea where personprogramid = '7ede6f2f-c80e-47e2-b8c7-a5d0801c69db';

update 	personprogramarea
set 	subprogramkey = 'FPS', updatedby = 'CDM-20448', updatedon = now()
where 	personprogramid = '7ede6f2f-c80e-47e2-b8c7-a5d0801c69db';

--Aviyah K Sebro
select activeflag, programkey, subprogramkey, * from personprogramarea where personprogramid = 'd2108b76-7b9e-4d50-b840-9df871737475';

update 	personprogramarea
set 	subprogramkey = 'FPS', updatedby = 'CDM-20448', updatedon = now()
where 	personprogramid = 'd2108b76-7b9e-4d50-b840-9df871737475';
