/*

Issue : Purchase authorization cannot be denied
Root Cause : The supervisor returned purchase authorization 3532502 (07/12/2024 - 07/13/2024)
asking the worker to change the end date to 7/13 - 7/14. The worker created a new
authorization for those dates instead, and that one was approved and paid. To deny the
returned one the worker has to send it in again, but the screen refuses because another
authorization already covers overlapping dates - it only lets a duplicate through when that
other one is already Denied. The approved one will never be Denied, so the returned request
can never be sent in and can never be denied from the screen.
Fix Provided  : Set the returned authorization straight to Denied. The screen then shows it
as Denied and the worker no longer has anything pending. 
Datafix/Code fix ticket : CJAMS-69261
Regression impacts: N
Is code fix required: N
Why code fix is required: purchase authorization already exists for the selected dates so the system is not allowing

 */


update routing
set routingstatustypeid= 62,
routeddescription='Denied CJAMS-69261',
remarks='Denied',
updatedby='CJAMS-69261',
updatedon=now()
where  routingid='08b44cf1-e35e-48ea-ab65-2d03bc1af256' and eventcode='PCAUTH';