/*
Issue Description: CJAMS-66140
Root Cause :We got an approval from Eugene Hildebrand Proceed to update the Date of Birth (DOB) : 05/31/1967. for the following record:

CJAMS PID #: 204800792

CPS History Clearance Intake #: I261013923792

The DOB currently listed in CJAMS is 06/01/1967, which is incorrect.
The correct DOB is 05/31/1967.
Data fix :Updated dob.
Category/ Module: person 
Pull request# N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A
*/


update person 
set dob='1967-05-31 00:00:00',updatedby='CJAMS-66140',updatedon=now() 
where cjamspid='204800792' and activeflag = 1;