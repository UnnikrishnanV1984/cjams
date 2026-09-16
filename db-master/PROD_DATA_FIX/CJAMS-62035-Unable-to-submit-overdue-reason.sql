
/*
Issue Description:SSA instructed us to enter note in comment box. However, we are not able to enter the comment and we are not able to submit.
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
	set cpsresponsetimerreason1 = 'VDER', --null
	cpsresponsetimerreason7 = 'CDER', --CCNT
	cpsresponsetimerreason8 = null,--CSDT
    updatedby ='CJAMS-62035',
    updatedon =now(),
    caseworkercomments ='The initial visit met the timeliness requirement, but that because the case was originally screened out, the timer did not correctly capture that timely contact.'--Case assigned to CPS worker around 2PM on 7/18. 
where cpsresponsetimeractionsid = '30967e54-daad-4cb2-95b2-6bf5c2b55abf'
and intakeserviceid = 'bc48d53c-227e-48b3-8b72-f3a737be1be2';