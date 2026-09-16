/*
Issue Description: CJAMS-68315
Category/ Module  : Annual Review date change
Root cause: user wants to change gap annual date review and remove the last record as it was entered in error
Fix provided: Data fix is done to modify the gap annual date
Is code fix required: N 
Why no code fix is required: User error
Status of the code fix if already submitted and expected prod fix date: 
 */
update gapannualreview
set
    reviewdate = '2025-12-23 06:00:00',
    updatedby = 'CJAMS-68315',
    updatedon = now ()
where
    gapannualreviewid = '18673d7f-5ea2-471c-b1b5-f1f1477e3717' and activeflag=1;

update gapannualreview
set
    activeflag = 0,
    updatedby = 'CJAMS-68315',
    updatedon = now ()
where
    gapannualreviewid = '6a12407f-1a99-4948-9245-bfd0b86ebd6e'
    and activeflag = 1;

update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-68315',
    updatedon = now ()
where
    objectid = '6a12407f-1a99-4948-9245-bfd0b86ebd6e'
    and eventcode = 'GAYR'
    and activeflag = 1;