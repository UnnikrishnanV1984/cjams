/*
   Issue Description: CJAMS-58094
   Category/ Module  : placement
   Root cause:  living arrangement was added on 2021 and we have not implemented the 
   validation that the Relative/fictive kin home living arrangement can not be overlapped at that time.so Data fix is done to remove the living arrangements
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update placement set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58094' 
where placementid in ('8c4b37e3-a1e8-479b-a32b-8f648722bf8b', 
'ae87045c-2acf-4c4f-ace2-ebeac9abdd8d','84dbaf44-1eef-460c-9611-7b1842e45fbe','91d3f277-0640-4944-ac84-7dec8dd6a3c0') and activeflag=1;

update placementrevision set  activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58094' 
where placementid in ('8c4b37e3-a1e8-479b-a32b-8f648722bf8b', 
'ae87045c-2acf-4c4f-ace2-ebeac9abdd8d','84dbaf44-1eef-460c-9611-7b1842e45fbe','91d3f277-0640-4944-ac84-7dec8dd6a3c0') and activeflag=1;

update livingarrangement set  activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58094' 
where placementid in ('8c4b37e3-a1e8-479b-a32b-8f648722bf8b', 
'ae87045c-2acf-4c4f-ace2-ebeac9abdd8d','84dbaf44-1eef-460c-9611-7b1842e45fbe','91d3f277-0640-4944-ac84-7dec8dd6a3c0') and activeflag=1;

update routing  set  activeflag = 0, updatedon = now(), updatedby = 'CJAMS-58094' 
where objectid in ('8c4b37e3-a1e8-479b-a32b-8f648722bf8b', 
'ae87045c-2acf-4c4f-ace2-ebeac9abdd8d','84dbaf44-1eef-460c-9611-7b1842e45fbe','91d3f277-0640-4944-ac84-7dec8dd6a3c0') and activeflag =1;

