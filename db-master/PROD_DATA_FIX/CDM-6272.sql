--CDM-6272 - change supervisor disposition to screen out
UPDATE intakesnapshot 
SET jsondata = REPLACE (jsondata :: TEXT, '"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::jsonb
WHERE intakenumber = 'I202000691786' AND activeflag = 1;