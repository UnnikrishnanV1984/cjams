/*
   Issue Description: CDM-27105
   Category/ Module  : Permanency Plan
   Root cause: user requested  to remove the incomplete subsidy rate , so that break the line can be send for approval
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionagreementraterevision set activeflag =0,
updatedby ='CDM-27105',
updatedon =now()
where adoptionagreementraterevisionid ='10ca2ede-6deb-4969-987e-38ea573c32dd';

update adoptionagreement set activeflag = 0,
updatedby ='CDM-27105',
updatedon =now() 
where adoptionagreementid = 'ffe23357-b1e2-4b67-aced-f01e616baf57';