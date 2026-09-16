/* 
 Issue Description: CDM-40596
 Category/ Module  : Placements
 Root cause: User Request (handle duplicates)
 Pull request# for code fix: N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 
 */
update
   placement
set
   activeflag = 0,
   updatedby = 'CDM-40596',
   updatedon = now()
where
   placementid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3'
   and activeflag = 1;

update
   placementrevision
set
   activeflag = 0,
   updatedby = 'CDM-40596',
   updatedon = now()
where
   placementid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3'
   and activeflag = 1;

update
   livingarrangement
set
   activeflag = 0,
   updatedby = 'CDM-40596',
   updatedon = now()
where
   placementid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3'
   and activeflag = 1;

update
   routing
set
   activeflag = 0,
   updatedby = 'CDM-40596',
   updatedon = now()
where
   objectid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3'
   and activeflag = 1;