/*
  Issue Description:  CDM-40769
   Category/ Module  :  Placement 
   Root cause: User request to Data fix to remove the placements
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update placement set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where placementid = 'd45e4425-2699-4ac1-829e-ec169e8e5642';

update livingarrangement set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where placementid = 'd45e4425-2699-4ac1-829e-ec169e8e5642';

update placementrevision 
set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()  
where placementid = 'd45e4425-2699-4ac1-829e-ec169e8e5642'
 and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where routingid = '3db3399b-1814-49f5-a8a5-c9d11b71ec6d' and objectid  = 'd45e4425-2699-4ac1-829e-ec169e8e5642' and activeflag = 1;

--------------------------------

update placement set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where placementid = 'eb4b845b-9393-43cd-9d4a-e3a0b1018e13';

update livingarrangement set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where placementid = 'eb4b845b-9393-43cd-9d4a-e3a0b1018e13';

update placementrevision 
set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()  
where placementid = 'eb4b845b-9393-43cd-9d4a-e3a0b1018e13'
 and activeflag = 1;


update routing 
set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where routingid = '66c54449-a2dd-4b0d-a464-cc6ed30e1c2e' and objectid  = 'eb4b845b-9393-43cd-9d4a-e3a0b1018e13' and activeflag = 1;

--

update placement set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where placementid = '2fa7f0c3-1c8c-4027-ae37-01e6accf3413';

update livingarrangement set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where placementid = '2fa7f0c3-1c8c-4027-ae37-01e6accf3413';

update placementrevision 
set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()  
where placementid = '2fa7f0c3-1c8c-4027-ae37-01e6accf3413'
 and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CDM-40769', updatedon = now()
where routingid = '16a80bc5-5c23-4212-b4e0-7ec5cafa817f' and objectid  = '2fa7f0c3-1c8c-4027-ae37-01e6accf3413' and activeflag = 1;