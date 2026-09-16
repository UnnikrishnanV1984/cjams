/*
   Issue Description: 231030232592:Data fix needed Removal date on child removal screen should be 3-13-24 not 3-18-24 and 
   placement upon entry should be hospitalization. Audit log shows on 3/21/24 removal date of 3/18/24 was entered but was 
   corrected to 3/13/24 on 3/22/24 and then approved but 3/18/24 is showing as the removal date on the Child Removal screen. 
   Category/ Module  : Child Removal
   Root cause: user wants to correct the child removal date and placement upon entry for the case 231030232592
   Fix Provided: Data fix has been promoted to update to set the revision record to active which was soft delted
*/



select activeflag,agencytypekey,updatedon,intakeservreqchildremovalhistoryid,intakeservreqchildremovalid,removaldate,removaltime,*from intakeservreqchildremoval_history where intakeservreqchildremovalid='3cf80c2e-94cd-445e-b0a7-b06fb92f4468' order by updatedon desc limit 1;



update intakeservreqchildremoval_history
set activeflag = 1,
updatedby = 'CDM-37989', 
updatedon = now ()
where intakeservreqchildremovalid='3cf80c2e-94cd-445e-b0a7-b06fb92f4468' 
and intakeservreqchildremovalhistoryid = '8b71a775-72dd-4706-8d41-05b2e7c7b2eb';

