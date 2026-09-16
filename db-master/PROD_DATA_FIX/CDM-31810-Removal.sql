/*
   Issue Description: CDM-31810
   Category/ Module  : Child removal 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update cjams.intakeservreqchildremoval 
set 
exitdate= '2023-05-08 00:00:00', updatedon = now(), updatedby = 'CDM-31810' 
where removalid = 192321 and activeflag = 1;

update cjams.intakeservreqchildremoval 
set 
exitdate= '2023-05-08 00:00:00', updatedon = now(), updatedby = 'CDM-31810' 
where removalid = 192324 and activeflag = 1;

update cjams.personprogramarea 
set
enddate = '2023-05-08 00:00:00',
updatedon = now(), updatedby ='CDM-31810'
where personprogramid in ('b76ca2e5-b1bc-456c-a7d6-d3137048fa41','7a056d1a-cbac-4cc0-bfcf-ac002b279808');

update tb_client_eligibility set end_dt ='2023-05-08', update_ts =now(), update_user_id ='CDM-31810'
where removal_id in ('192324','192321') and delete_sw ='N';

--history and routing records are good 