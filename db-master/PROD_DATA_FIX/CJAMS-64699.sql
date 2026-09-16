/*
Issue: CJAMS-64699
User requested to Update overdue reasons as listed below on closed case
		
For the alleged victim please select alleged victim unavailable > Attempted Face to face > 3-4 attempts

For the other children please select other children unavailable > Insufficient information reported - attempts were made to obtain
> 1-2 attempts

In the comment box please include:
ALLEGED VICTIM; 1/1/26 5:30 PM, After Hours Worker called Laniyah's mother and she stated Laniyah is not home and she was unsure where she currently is.1/1/26 6:45 PM, After Hours Worker went to the location of the incident where Laniyah was possibly located, Laniyah was not present. 1/1/26 9:00 PM, After Hours Worker went to Laniyah's home face to face, Laniyah was not home and contact was not made.1/2/26 2:18 PM, This worker attempted to call Laniyah's mother. 1/7/26 this worker added Laniyah as an "alleged victim" in the case1/7/26 11:11 AM, This worker saw Laniyah at school and interviewed her.

OTHER CHILD: Nikolai was not included in the case originally so worker was unaware contact needed to be made. When worker went to another child's home on 1/9/26 worker was informed that Nikolai also resides in the home and worker then made contact with the child. Nikolai was not present in the home at the time that the incident occurred and when initial contact was made, due to being at his father's home. However, there was a phone call and home visit during the timeframe where the child was not mentioned, however, are entered as attempts after learning that Nikolai is now a household member.


Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64699
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VAFF', 
		cpsresponsetimerreason3 = 'V34F', 
		cpsresponsetimerreason4 = 'OOCN', 
		cpsresponsetimerreason5 = 'OIIN', 
		cpsresponsetimerreason6 = 'O12N', 
		caseworkercomments = 'Nikolai was not included in the case originally so worker was unaware contact needed to be made. When worker went to another child''s home on 1/9/26 worker was informed that Nikolai also resides in the home and worker then made contact with the child. Nikolai was not present in the home at the time that the incident occurred and when initial contact was made, due to being at his father''s home. 
ALLEGED VICTIM; 1/1/26 5:30 PM, After Hours Worker called Laniyah''s mother and she stated Laniyah is not home and she was unsure where she currently is.1/1/26 6:45 PM, After Hours Worker went to the location of the incident where Laniyah was possibly located, Laniyah was not present. 1/1/26 9:00 PM, After Hours Worker went to Laniyah''s home face to face, Laniyah was not home and contact was not made.1/2/26 2:18 PM, This worker attempted to call Laniyah''s mother. 1/7/26 this worker added Laniyah as an "alleged victim" in the case1/7/26 11:11 AM, This worker saw Laniyah at school and interviewed her. 
OTHER CHILD: Nikolai was not included in the case originally so worker was unaware contact needed to be made. When worker went to another child''s home on 1/9/26 worker was informed that Nikolai also resides in the home and worker then made contact with the child. Nikolai was not present in the home at the time that the incident occurred and when initial contact was made, due to being at his father''s home. However, there was a phone call and home visit during the timeframe where the child was not mentioned, however, are entered as attempts after learning that Nikolai is now a household member.',
		updatedby = 'CJAMS-64699',
		updatedon = now()
where cpsresponsetimeractionsid = '41b1919e-91bb-4fac-b5c4-a420bc43faad'
	and activeflag = 1;
	
