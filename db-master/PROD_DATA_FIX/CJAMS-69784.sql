/*

Issue : subject name is incorrect in the narative section
Root Cause : The worker typed the wrong subject name in the narrative when creating the
intake. The clearance was requested for Noelle Kline, but the narrative was written for
"katherine woof". The narrative is held in two places for this intake - the intake record
itself, the staging copy, and the approved snapshot copy. All three carry the same wrong
name. This intake is already approved and closed, so the screen reads the approved snapshot
copy - correcting only the intake record and the staging copy leaves the screen unchanged.
Fix Provided  : Correct the narrative text in all three places so it names Noelle Kline, as
confirmed with the user. Only the narrative wording is corrected
Datafix/Code fix ticket : CJAMS-69784
Regression impacts: N
Is code fix required: N
Why no code fix is required: the wrong name was manually typed by the user
 */


UPDATE intakeservicerequest
   SET narrative  = '<p>grace&nbsp;graham&nbsp;of&nbsp;wa&nbsp;department&nbsp;of&nbsp;children&nbsp;youth&nbsp;and&nbsp;families&nbsp;requested&nbsp;a&nbsp;cps&nbsp;clearance&nbsp;for&nbsp;Noelle&nbsp;Kline</p>',
       updatedby  = 'CJAMS-69784'
 WHERE intakenumber = 'I261014132818'
   AND narrative   = '<p>grace&nbsp;graham&nbsp;of&nbsp;wa&nbsp;department&nbsp;of&nbsp;children&nbsp;youth&nbsp;and&nbsp;families&nbsp;requested&nbsp;a&nbsp;cps&nbsp;clearance&nbsp;for&nbsp;katherine&nbsp;woof</p>';



UPDATE intakedastaging
   SET jsondata  = jsonb_set(jsondata, '{General,Narrative}',
                     to_jsonb('<p>grace&nbsp;graham&nbsp;of&nbsp;wa&nbsp;department&nbsp;of&nbsp;children&nbsp;youth&nbsp;and&nbsp;families&nbsp;requested&nbsp;a&nbsp;cps&nbsp;clearance&nbsp;for&nbsp;Noelle&nbsp;Kline</p>'::text),
                     false),
       updatedby = 'CJAMS-69784'
 WHERE intakenumber = 'I261014132818'
   AND activeflag  = 1
   AND jsondata #>> '{General,Narrative}' =
       '<p>grace&nbsp;graham&nbsp;of&nbsp;wa&nbsp;department&nbsp;of&nbsp;children&nbsp;youth&nbsp;and&nbsp;families&nbsp;requested&nbsp;a&nbsp;cps&nbsp;clearance&nbsp;for&nbsp;katherine&nbsp;woof</p>';



UPDATE intakesnapshot
   SET jsondata  = jsonb_set(jsondata, '{General,Narrative}',
                     to_jsonb('<p>grace&nbsp;graham&nbsp;of&nbsp;wa&nbsp;department&nbsp;of&nbsp;children&nbsp;youth&nbsp;and&nbsp;families&nbsp;requested&nbsp;a&nbsp;cps&nbsp;clearance&nbsp;for&nbsp;Noelle&nbsp;Kline</p>'::text),
                     false),
       updatedby = 'CJAMS-69784'
 WHERE intakenumber = 'I261014132818'
   AND activeflag  = 1
   AND jsondata #>> '{General,Narrative}' =
       '<p>grace&nbsp;graham&nbsp;of&nbsp;wa&nbsp;department&nbsp;of&nbsp;children&nbsp;youth&nbsp;and&nbsp;families&nbsp;requested&nbsp;a&nbsp;cps&nbsp;clearance&nbsp;for&nbsp;katherine&nbsp;woof</p>';




