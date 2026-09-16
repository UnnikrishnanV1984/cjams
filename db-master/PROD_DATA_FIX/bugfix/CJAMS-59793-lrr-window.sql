/*
  Issue Description: CJAMS-59793 - 251023002607:Please revise the Alleged Victim reasons in the LRR window.Alleged victim has both "after hours worker unable to meet mandate for assigned worker" and "police called for welfare check but unable to meet mandate."Please only select "police called for welfare check but unable to meet mandate" and remove the check from "after hours worker unable to meet mandate for assigned worker"
  Root cause: User added both the options before submitting for the approval and requested to update to remove 1 option
  Fix provided : Fix provided by updating the reason to VPMR
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

-- select * from cpsresponsetimeractions c where cpsresponsetimeractionsid ='ebeed41a-2f0b-4cb1-be16-75781485d5a4';

update cpsresponsetimeractions
set cpsresponsetimerreason2 ='["VPMR"]', updatedby ='CJAMS-59793', updatedon =now()
where cpsresponsetimeractionsid ='ebeed41a-2f0b-4cb1-be16-75781485d5a4';