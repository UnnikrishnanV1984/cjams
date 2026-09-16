/*
   Issue Description: CJAMS-60410
        Placement Duplicate
   Category/ Module  : Placement Duplicate
   Root cause:  Data fix to remove duplicate living arrangement created. 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update
    livingarrangement
set
    activeflag = 0 ,
    updatedon = now(),
    updatedby = 'CJAMS-60410'
where
    placementid = '25c73e2f-d23c-41d5-b9da-571c3f25d048';


update
    placement
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-60410'
where
    placementid = '25c73e2f-d23c-41d5-b9da-571c3f25d048';


update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CJAMS-60410',
    updatedon = now()
where
    placementid = '25c73e2f-d23c-41d5-b9da-571c3f25d048'
    and activeflag = 1;
   
update
  routing 
set activeflag = 0,
    updatedby = 'CJAMS-60410',
    updatedon = now()
where 
   objectid = '25c73e2f-d23c-41d5-b9da-571c3f25d048'
   and activeflag = 1;