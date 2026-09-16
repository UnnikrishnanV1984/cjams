/*

Issue : Purchase authorization cannot be denied 
Root Cause : Two purchase authorizations were created for the same service log and the same
dates (12/01/2025 - 12/31/2025) minutes apart. One was approved and paid, the other was
returned to the worker. To deny the returned one the worker has to send it in again, but the
screen refuses because another authorization already covers the same dates - it only lets a
duplicate through when that other one is already Denied. The paid one will never be Denied,
so the returned request can never be sent in and can never be denied from the screen.
Fix Provided  : Set the returned authorization straight to Denied. The screen then shows it
as Denied and the worker no longer has anything pending. Nothing is paid or unpaid by this
change, and the approved authorization is not touched.
Datafix/Code fix ticket : CJAMS-69034
Regression impacts: N
Is code fix required: N
Why code fix is required: purchase authorization already exists for the selected dates so the system is not allowing

 */


update routing
set routingstatustypeid= 62,
routeddescription='Denied CJAMS-69034',
remarks='Denied',
updatedby='CJAMS-69034',
updatedon=now()
where  routingid='5bf3b666-4e45-4c55-a597-99909c0eea89' and eventcode='PCAUTH';
