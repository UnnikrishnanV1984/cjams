/*
   Issue Description: CDM-41532 Duplicate ACAs on my Dashboard
   Category/ Module  :Title IV-E
   Root cause: Data fix needed to remove two ACA cases from IV-E dashboard which have already been approved and resumbitted by supervisor.
   Fix provided : Data fix has been done to remove ACA cases from IV-E dashboard.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update adoptionapplicabilityinfo
set activeflag = 1,
updatedby = 'CDM-41532',
ivestatus = 'APPROVED',
updatedon = now()
where adoptionapplicabilityid in('7abce2eb-7693-4d28-af1d-bf06b0db9912','60024177-d1bd-42f5-9c66-6882fbd11011');

update routing
set activeflag = 0,
updatedby = 'CDM-41532',
updatedon = now()
where objectid in ('7abce2eb-7693-4d28-af1d-bf06b0db9912','60024177-d1bd-42f5-9c66-6882fbd11011')
and activeflag = 1;

