/*
  Issue Description:  CDM-39866
   Category/ Module  :  Decision
   Root cause: user requested to change neglect finding to unsubstantiated
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=199867 and referral_id='CW2223926'; 

update investigationfinding
set investigationfindingtypekey = 'UD',
updatedby = 'CDM-39866',
    updatedon = now()
    where investigationfindingid in ('03d664c4-4680-4118-b4d7-5de80eabad3d','f8b77c22-b0c5-4279-b9ed-1e73ccc9b07f') and activeflag =1;