/*
   Issue Description: CJAMS-67919
   Category/ Module:Closed GAP Case
   Root cause:Please remove last subsidy rate slab and annual review as shown in the screenshots for 

            Client Name
            RAYAH WILLIAMS

            CJAMS PID #
            3954807
   Fix Provided : Data fix is done 
   Pull request# for code fix:  N/A
   Is code fix required:
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update gapannualreview 
set activeflag=0, updatedby='CJAMS-67919', updatedon = now() 
where gapannualreviewid = '6b9e3608-d0bc-4b76-a852-7526a4293124' and activeflag = 1;

update routing 
set activeflag=0, updatedby='CJAMS-67919', updatedon = now() 
where objectid = '6b9e3608-d0bc-4b76-a852-7526a4293124' and activeflag = 1;


update gapagreementrate
set activeflag = 0 , 
    updatedon = now(),
    updatedby = 'CJAMS-67919'
where gapagreementrateid = 'a8193978-0087-4e35-b073-0eb73e914c51'    
and activeflag = 1;

update gapratesrevision
set activeflag = 0 , 
    updatedon = now(),
    updatedby = 'CJAMS-67919'
where gaprateid = 'a8193978-0087-4e35-b073-0eb73e914c51'    
and activeflag = 1;

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-67919'
where objectid = 'a8193978-0087-4e35-b073-0eb73e914c51'    
and activeflag = 1;



