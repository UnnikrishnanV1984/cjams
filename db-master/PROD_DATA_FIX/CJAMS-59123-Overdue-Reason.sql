

/*
Issue Description:251022986732:Case #: 251022986732Please add the following drop-down selections for the Alleged Victim and for the Other Children:Data Entry Error but Face to Face Mandate Met.The initial call to screening was screened out on 1/21/2025. A subsequent call came in on 1/23/2025 and the case was turned around and accepted/assigned. The case start date should have been 1/23/2025. SSA is aware of this glitch and is working on a fix. 
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-59123
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VDER', 
    cpsresponsetimerreason4 =  'ODER',
    updatedby ='CJAMS-59123',
    updatedon =now()
where cpsresponsetimeractionsid = 'f6f0fda6-69e0-4d17-8226-83ccfe9ed7e4'
and activeflag = 1;