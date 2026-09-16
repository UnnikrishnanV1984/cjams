/*
 Issue Description:CIDM-10094,NCANDS - Report date needs to be corrected for Three Intake Numbers
 Category/ Module: Data fix needed
 Root cause: NCANDS - Report date needs to be corrected for Three Intake Numbers
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select jsondata,* from intakesnapshot i 
where intakenumber in ('I241012064642','I231011648517','I241012055408')
and activeflag =1;

I231011648517: "CreatedDate": "2023-12-06T03:10:51.063Z", ---> 12/05/2023
I241012055408:     "CreatedDate": "2024-01-28T01:24:45.953Z", ---> 01/27/2024
I241012064642:     "CreatedDate": "2024-02-10T01:36:34.132Z", ----> 02/09/2024
*/

UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata, '{General,CreatedDate}', '"2023-12-05T03:10:51.063Z"'),
	updatedby = 'CIDM-10094',
	updatedon = now()
WHERE intakenumber = 'I231011648517' and activeflag =1;


UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata, '{General,CreatedDate}', '"2024-01-27T01:24:45.953Z"'),
	updatedby = 'CIDM-10094',
	updatedon = now()
WHERE intakenumber = 'I241012055408' and activeflag =1;

UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata, '{General,CreatedDate}', '"2024-02-9T01:36:34.132Z"'),
	updatedby = 'CIDM-10094',
	updatedon = now()
WHERE intakenumber = 'I241012064642' and activeflag =1;