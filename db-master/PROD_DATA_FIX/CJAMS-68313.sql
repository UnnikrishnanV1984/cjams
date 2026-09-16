/*
Issue Description: CJAMS-68313
Category/ Module  : Annual Review date change
Root cause: user wants to change gap annual date review and remove the last record as it was entered in error
Fix provided: Data fix is done to modify the gap annual date
Is code fix required: N 
Why no code fix is required: User error
Status of the code fix if already submitted and expected prod fix date: 
 */
update gapannualreview
set
    reviewdate = '2025-12-21 20:00:00',
    updatedby = 'CJAMS-68313',
    updatedon = now ()
where
    gapannualreviewid = '1ae6c669-a645-4308-9caa-c3b660dc3750' and activeflag =1;

update gapannualreview
set
    activeflag = 0,
    updatedby = 'CJAMS-68313',
    updatedon = now ()
where
    gapannualreviewid = '418927b9-8010-4a12-9e05-7e34a97c4365'
    and activeflag = 1;

update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-68313',
    updatedon = now ()
where
    objectid = '418927b9-8010-4a12-9e05-7e34a97c4365'
    and eventcode = 'GAYR'
    and activeflag = 1;
