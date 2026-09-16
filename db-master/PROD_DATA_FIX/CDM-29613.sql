/*
   Issue Description: CDM-29613
   Category/ Module  :contacts Tab 
   Root cause: user wants to remove contacts 10570966,10616937,10663385
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/



update progressnote set activeflag=0, updatedby ='CDM-29613', updatedon = now()
where progressnoteid in('0efa8500-77bd-4639-8269-24b172b58f24','dfaca301-3ab0-4621-b0cb-5cef573da6d8','04cffbf8-3fbf-4ff3-bd7a-7cf631530855');

--select progressnotedetailid from progressnotedetail  where progressnoteid in('0efa8500-77bd-4639-8269-24b172b58f24','dfaca301-3ab0-4621-b0cb-5cef573da6d8','04cffbf8-3fbf-4ff3-bd7a-7cf631530855');
update progressnotedetail set activeflag=0, updatedby ='CDM-29613', updatedon = now() 
where progressnotedetailid in('01e6e317-3828-4da2-b17e-958d84e217b8','e7aad8e4-9ca0-4115-a408-b611506b2a5d','fc4fc91f-6e1f-426a-8081-fcbb4e59315a');

--select auditdetailid from progressnote_audit_detail where conatctid in (10570966,10616937,10663385);
update progressnote_audit_detail set activeflag=0, updatedby ='CDM-29613', updatedon = now() 
where auditdetailid in('fce9a606-a1e4-4041-a5a9-cc7ec93cbe0d','25515796-a396-4358-9b34-9804ff473642','f49abb97-bb82-4174-85f9-89eb684a5c81');

update  contactparticipant set  activeflag=0, updatedby ='CDM-29613', updatedon = now() 
where progressnoteid in('0efa8500-77bd-4639-8269-24b172b58f24','dfaca301-3ab0-4621-b0cb-5cef573da6d8','04cffbf8-3fbf-4ff3-bd7a-7cf631530855')
and activeflag=1;
