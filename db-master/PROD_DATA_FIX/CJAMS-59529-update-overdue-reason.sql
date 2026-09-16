/*
Issue Description:CJAMS-59529 Drop down reasons missing from Legislative Required Reporting window
Category/Module: Overdue Reason
Root cause: ShanelleLopez is the user who created the cpsresponsetimer request. This user has been deactivated and we are unable to see the CPSresponse timer request that is being pulled from V_userprofile table.
            The old history record is missing due to the user profile deactivation and it should be available once the code fix CIDM-10519 is deployed.
            We need a data fix to update the following information
            Alleged victim unavailable > Attempted face to face > 1-2 attempts and
            ICC unavailable > Attempted face to face > 1-2 attempts
            We will not update the over due snapshot as it is already available.
            Code fix might be needed to show the history information even after the user profile gets deactivated.
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged victim unavailable > Attempted face to face > 1-2 attempts and
                ICC unavailable > Attempted face to face > 1-2 attempts
                The data fix would be visible after the deployment of code fix CIDM-10519
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10519 
Reason why no related code fix: Data fix needed to correct the user entry error and Code fix is needed to show the history even after the user profile is deactivated.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    cpsresponsetimerreason7 = 'CCCN',
    cpsresponsetimerreason8 = 'CFFN',
    cpsresponsetimerreason9 = 'C12F', 
    updatedon = now(),
    updatedby = 'CJAMS-59529'
where cpsresponsetimeractionsid = '0948e130-61b3-4b17-ae00-cecee9f97294'
and intakeserviceid = '3474955a-adc3-47bd-a450-3309db0fda78';