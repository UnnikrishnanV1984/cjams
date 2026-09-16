/*
Issue Description:251023079173:Case # 251023079173HB1248 Missing Reason - missing response timer drop down for Contact with Alleged Victim. Please add:Alleged Victim UnavailableAttempted Face to Face3-4 Attempts Screen
Root cause: Incorrect response reason was selected due to a dropdown misselection during entry, leading to an inaccurate mandate violation.
Fix provided: Data fix has been done to update the cpsresponsetimeractions table.
Data/Code fix ticket#: CJAMS-60668
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 = 'V34F',updatedby = 'CJAMS-60668',updatedon = now()
where activeflag = 1 and cpsresponsetimeractionsid in ('9a7d3953-16e9-4a72-96a1-06b42781661a',
'16bcec2b-b941-4f76-aa67-870a26bce45b');