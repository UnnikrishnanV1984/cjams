/*
Issue Description: Need data fix to close the case from the backend.
Category/ Module: Bug
Root cause: Case was re-opened to re-enter dispositions and now it won't allow to send for closure.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-40152
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing to close the case
update routing 
set 
	routingstatustypeid = 2, activeflag = 1, updatedby = 'CDM-40152', updatedon = now()
where routingid = '185636bc-92c3-4772-8788-d27d2afabb06';

--Updating approval date in routing
update routing
set
	insertedon = '2024-07-22 11:00:00', fromsecurityusersid = '07a546d5-9823-49d4-9167-5228b43e47d1',
	updatedby = 'CDM-40152', updatedon = now()
where routingid = '309af27a-6b7c-4bad-ad33-ab64642a186c' and activeflag = 1;

--Updating intakeservicerequestdispositioncode to close the case
update intakeservicerequestdispositioncode
set 
	activeflag = 1, statusdate = '2024-07-22 10:00:00', insertedon = '2024-07-22 10:00:00',
	reviewcomments = 'Case was re-opened to re-enter dispositions as the original case had a bug and did not show all dispositions when being reviewed. Clients were deleted from the case. Once they were re-added their original dispositions showed again.',
	intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-40152', updatedon = now()
where intakeservicerequestdispositioncodeid = '0566139e-65b9-4a5e-817d-789688baeae0';

--Updating intakeservicerequest to close the case
update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-40152', updatedon = now()
where intakeserviceid = 'bb34519e-a8cf-4ca9-a777-5a0fbfed5bd3' and activeflag = 1;

--Updating caseassignment to set end date
update caseassignment
set enddate = '2020-07-17 23:38:01.542', updatedby = 'CDM-40152', updatedon = now()
where caseassignmentid = '70ed1ec9-c413-4fb2-8714-1dec7542a97a' and activeflag = 1;

--Updating personprogramarea to set end date_part
update personprogramarea 
set enddate = '2020-07-17 23:38:01.542', updatedby = 'CDM-40152', updatedon = now()
where activeflag = 1 and personprogramid in (
'2a37a665-a845-41d6-a0ab-5da2c2753500',
'0a9eb343-0ee7-4a7d-9a70-8b5a9d3a61ba',
'97144aab-b55c-47c1-a214-bc231519f8bb',
'bc377603-7dc2-4b72-8012-f51fe64b4560',
'c1515913-1ef4-4240-a8c9-7ff3bfd814a0',
'1de39c11-2a9b-4610-b4f9-d2ddd7ce89c2',
'05682c84-5fdb-4f62-a58c-89e202155324');