/*
Issue Description:
Category/Module: Bug
Root cause: 1. Screen out the intake# I261013914968
2. Text to be added in the Narrative of the intake# I261013914968 :
Intake#I261013914968 Addendum: This intake was screened out following receipt of new information-baby positive for controlled substance- on 3/3/2026, after the ROH,CI intake #I261013914968 was screened in and service case #3288101 assigned. A new SEN ROH intake# I26101397621 was created and linked to service case #3288101.
3. intake # I261013976217
Text to be added in the narrative:
Addendum: The ROH/CI intake (I261013914968) narrative was updated, and Caregiver Impairment was selected to support the agencys appropriate response and ensure all relevant information is captured.
4. intake # I261013976217
Add the Maltreatment type - Child's basic needs are likely to be unmet due to caregiver impairment(SDM changes should reflect in the case)
Fix provided:DB query to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-66721
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/* 2. Text to be added in the Narrative of the intake# I261013914968 :
Intake#I261013914968 Addendum: This intake was screened out following receipt of new information-baby positive for controlled substance- on 3/3/2026, after the ROH,CI intake #I261013914968 was screened in and service case #3288101 assigned. A new SEN ROH intake# I26101397621 was created and linked to service case #3288101.

*/
update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><strong>PM&nbsp;consult&nbsp;required</strong></p><p></p><p>Reporter&nbsp;stated&nbsp;mom&nbsp;gave&nbsp;birth&nbsp;yesterday&nbsp;and,&nbsp;although&nbsp;the&nbsp;cord&nbsp;results&nbsp;are&nbsp;not&nbsp;back&nbsp;yet,&nbsp;there&nbsp;are&nbsp;a&nbsp;lot&nbsp;of&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mom&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;mother&nbsp;denied&nbsp;using&nbsp;buprenorphine,&nbsp;although&nbsp;has&nbsp;a&nbsp;prescription&nbsp;through&nbsp;Black&nbsp;Rock,&nbsp;but&nbsp;it&nbsp;was&nbsp;confirmed&nbsp;she&nbsp;hadn&#39;t&nbsp;picked&nbsp;it&nbsp;up&nbsp;since&nbsp;1/21/26,&nbsp;claiming&nbsp;her&nbsp;boyfriend&nbsp;had&nbsp;stolen&nbsp;it.&nbsp;</p><p></p><p>Reporter&nbsp;stated&nbsp;mother&nbsp;is&nbsp;going&nbsp;through&nbsp;extensive&nbsp;withdrawal&nbsp;and&nbsp;they&nbsp;are&nbsp;concerned&nbsp;that&nbsp;mom&nbsp;can&#39;t&nbsp;stay&nbsp;awake&nbsp;long&nbsp;enough&nbsp;to&nbsp;perform&nbsp;any&nbsp;care&nbsp;for&nbsp;the&nbsp;baby.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;a&nbsp;nurse&nbsp;was&nbsp;at&nbsp;bedside&nbsp;to&nbsp;help&nbsp;feed&nbsp;the&nbsp;baby&nbsp;and&nbsp;mom&nbsp;kept&nbsp;dosing&nbsp;off&nbsp;and&nbsp;falling&nbsp;asleep.&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;keeps&nbsp;asking&nbsp;for&nbsp;help&nbsp;to&nbsp;feed&nbsp;the&nbsp;baby&nbsp;her&nbsp;bottle&nbsp;and&nbsp;has&nbsp;thrown&nbsp;up&nbsp;while&nbsp;feeding.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;has&nbsp;acknowledged&nbsp;that&nbsp;she&nbsp;should&nbsp;not&nbsp;be&nbsp;alone&nbsp;with&nbsp;the&nbsp;baby.&nbsp;&nbsp;Baby&nbsp;is&nbsp;currently&nbsp;in&nbsp;the&nbsp;nursery&nbsp;due&nbsp;to&nbsp;those&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;Ms.&nbsp;Gross&nbsp;has&nbsp;her&nbsp;mother,&nbsp;Mary&nbsp;Whorton,&nbsp;301.988.1093,&nbsp;listed&nbsp;as&nbsp;an&nbsp;emergency&nbsp;contact,&nbsp;however,&nbsp;on&nbsp;1/27/26&nbsp;provided&nbsp;a&nbsp;statement&nbsp;that&nbsp;no&nbsp;information&nbsp;should&nbsp;be&nbsp;given&nbsp;except&nbsp;to&nbsp;her&nbsp;sister,&nbsp;Crystal&nbsp;Rogers&nbsp;(Gross.)&nbsp;Mother&nbsp;advised&nbsp;she&nbsp;resides&nbsp;alone&nbsp;with&nbsp;her&nbsp;two&nbsp;other&nbsp;children.&nbsp;</p><p></p><p></p><p> Intake#I261013914968 Addendum: This intake was screened out following receipt of new information-baby positive for controlled substance- on 3/3/2026, after the ROH,CI intake #I261013914968 was screened in and service case #3288101 assigned. A new SEN ROH intake# I26101397621 was created and linked to service case #3288101.</p>')
	),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013914968' and activeflag = 1;

--Updating jsondata in intakedastatus

update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><strong>PM&nbsp;consult&nbsp;required</strong></p><p></p><p>Reporter&nbsp;stated&nbsp;mom&nbsp;gave&nbsp;birth&nbsp;yesterday&nbsp;and,&nbsp;although&nbsp;the&nbsp;cord&nbsp;results&nbsp;are&nbsp;not&nbsp;back&nbsp;yet,&nbsp;there&nbsp;are&nbsp;a&nbsp;lot&nbsp;of&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mom&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;mother&nbsp;denied&nbsp;using&nbsp;buprenorphine,&nbsp;although&nbsp;has&nbsp;a&nbsp;prescription&nbsp;through&nbsp;Black&nbsp;Rock,&nbsp;but&nbsp;it&nbsp;was&nbsp;confirmed&nbsp;she&nbsp;hadn&#39;t&nbsp;picked&nbsp;it&nbsp;up&nbsp;since&nbsp;1/21/26,&nbsp;claiming&nbsp;her&nbsp;boyfriend&nbsp;had&nbsp;stolen&nbsp;it.&nbsp;</p><p></p><p>Reporter&nbsp;stated&nbsp;mother&nbsp;is&nbsp;going&nbsp;through&nbsp;extensive&nbsp;withdrawal&nbsp;and&nbsp;they&nbsp;are&nbsp;concerned&nbsp;that&nbsp;mom&nbsp;can&#39;t&nbsp;stay&nbsp;awake&nbsp;long&nbsp;enough&nbsp;to&nbsp;perform&nbsp;any&nbsp;care&nbsp;for&nbsp;the&nbsp;baby.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;a&nbsp;nurse&nbsp;was&nbsp;at&nbsp;bedside&nbsp;to&nbsp;help&nbsp;feed&nbsp;the&nbsp;baby&nbsp;and&nbsp;mom&nbsp;kept&nbsp;dosing&nbsp;off&nbsp;and&nbsp;falling&nbsp;asleep.&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;keeps&nbsp;asking&nbsp;for&nbsp;help&nbsp;to&nbsp;feed&nbsp;the&nbsp;baby&nbsp;her&nbsp;bottle&nbsp;and&nbsp;has&nbsp;thrown&nbsp;up&nbsp;while&nbsp;feeding.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;has&nbsp;acknowledged&nbsp;that&nbsp;she&nbsp;should&nbsp;not&nbsp;be&nbsp;alone&nbsp;with&nbsp;the&nbsp;baby.&nbsp;&nbsp;Baby&nbsp;is&nbsp;currently&nbsp;in&nbsp;the&nbsp;nursery&nbsp;due&nbsp;to&nbsp;those&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;Ms.&nbsp;Gross&nbsp;has&nbsp;her&nbsp;mother,&nbsp;Mary&nbsp;Whorton,&nbsp;301.988.1093,&nbsp;listed&nbsp;as&nbsp;an&nbsp;emergency&nbsp;contact,&nbsp;however,&nbsp;on&nbsp;1/27/26&nbsp;provided&nbsp;a&nbsp;statement&nbsp;that&nbsp;no&nbsp;information&nbsp;should&nbsp;be&nbsp;given&nbsp;except&nbsp;to&nbsp;her&nbsp;sister,&nbsp;Crystal&nbsp;Rogers&nbsp;(Gross.)&nbsp;Mother&nbsp;advised&nbsp;she&nbsp;resides&nbsp;alone&nbsp;with&nbsp;her&nbsp;two&nbsp;other&nbsp;children.&nbsp;</p><p></p><p></p><p> Intake#I261013914968 Addendum: This intake was screened out following receipt of new information-baby positive for controlled substance- on 3/3/2026, after the ROH,CI intake #I261013914968 was screened in and service case #3288101 assigned. A new SEN ROH intake# I26101397621 was created and linked to service case #3288101.</p>')
	),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013914968' and activeflag = 1;

--Updating jsondata in intakesnapshot
update intakesnapshot
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><strong>PM&nbsp;consult&nbsp;required</strong></p><p></p><p>Reporter&nbsp;stated&nbsp;mom&nbsp;gave&nbsp;birth&nbsp;yesterday&nbsp;and,&nbsp;although&nbsp;the&nbsp;cord&nbsp;results&nbsp;are&nbsp;not&nbsp;back&nbsp;yet,&nbsp;there&nbsp;are&nbsp;a&nbsp;lot&nbsp;of&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mom&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;mother&nbsp;denied&nbsp;using&nbsp;buprenorphine,&nbsp;although&nbsp;has&nbsp;a&nbsp;prescription&nbsp;through&nbsp;Black&nbsp;Rock,&nbsp;but&nbsp;it&nbsp;was&nbsp;confirmed&nbsp;she&nbsp;hadn&#39;t&nbsp;picked&nbsp;it&nbsp;up&nbsp;since&nbsp;1/21/26,&nbsp;claiming&nbsp;her&nbsp;boyfriend&nbsp;had&nbsp;stolen&nbsp;it.&nbsp;</p><p></p><p>Reporter&nbsp;stated&nbsp;mother&nbsp;is&nbsp;going&nbsp;through&nbsp;extensive&nbsp;withdrawal&nbsp;and&nbsp;they&nbsp;are&nbsp;concerned&nbsp;that&nbsp;mom&nbsp;can&#39;t&nbsp;stay&nbsp;awake&nbsp;long&nbsp;enough&nbsp;to&nbsp;perform&nbsp;any&nbsp;care&nbsp;for&nbsp;the&nbsp;baby.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;a&nbsp;nurse&nbsp;was&nbsp;at&nbsp;bedside&nbsp;to&nbsp;help&nbsp;feed&nbsp;the&nbsp;baby&nbsp;and&nbsp;mom&nbsp;kept&nbsp;dosing&nbsp;off&nbsp;and&nbsp;falling&nbsp;asleep.&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;keeps&nbsp;asking&nbsp;for&nbsp;help&nbsp;to&nbsp;feed&nbsp;the&nbsp;baby&nbsp;her&nbsp;bottle&nbsp;and&nbsp;has&nbsp;thrown&nbsp;up&nbsp;while&nbsp;feeding.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;has&nbsp;acknowledged&nbsp;that&nbsp;she&nbsp;should&nbsp;not&nbsp;be&nbsp;alone&nbsp;with&nbsp;the&nbsp;baby.&nbsp;&nbsp;Baby&nbsp;is&nbsp;currently&nbsp;in&nbsp;the&nbsp;nursery&nbsp;due&nbsp;to&nbsp;those&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;Ms.&nbsp;Gross&nbsp;has&nbsp;her&nbsp;mother,&nbsp;Mary&nbsp;Whorton,&nbsp;301.988.1093,&nbsp;listed&nbsp;as&nbsp;an&nbsp;emergency&nbsp;contact,&nbsp;however,&nbsp;on&nbsp;1/27/26&nbsp;provided&nbsp;a&nbsp;statement&nbsp;that&nbsp;no&nbsp;information&nbsp;should&nbsp;be&nbsp;given&nbsp;except&nbsp;to&nbsp;her&nbsp;sister,&nbsp;Crystal&nbsp;Rogers&nbsp;(Gross.)&nbsp;Mother&nbsp;advised&nbsp;she&nbsp;resides&nbsp;alone&nbsp;with&nbsp;her&nbsp;two&nbsp;other&nbsp;children.&nbsp;</p><p></p><p></p><p> Intake#I261013914968 Addendum: This intake was screened out following receipt of new information-baby positive for controlled substance- on 3/3/2026, after the ROH,CI intake #I261013914968 was screened in and service case #3288101 assigned. A new SEN ROH intake# I26101397621 was created and linked to service case #3288101.</p>')
	),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013914968' and activeflag = 1;





--1. Screen out the intake# I261013914968


UPDATE intakesnapshot 
SET updatedby = 'CJAMS-66721', updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013914968' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed', updatedby = 'CJAMS-66721', updatedon = now(), 
    jsondata = jsonb_set(jsondata, '{DAType}',
        jsonb_set(jsondata->'DAType', '{DATypeDetail}',
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261013914968' AND activeflag=1;

update routing 
set supervisordecision = 'screenout', routingstatustypeid = 8, 
    updatedon = now()
where routingid='dbd22d7c-8561-4216-b8aa-30fb0a7febf6' and activeflag=1 and  objectid ='I261013914968';


/*
3. intake # I261013976217
Text to be added in the narrative:
Addendum: The ROH/CI intake (I261013914968) narrative was updated, and Caregiver Impairment was selected to support the agencys appropriate response and ensure all relevant information is captured.
*/

update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><strong>FYI&#39;s&nbsp;to&nbsp;worker,&nbsp;ShellyAnn&nbsp;Smallwood,&nbsp;her&nbsp;supervisor,&nbsp;and&nbsp;PM</strong></p><p></p><p>Amira&nbsp;was&nbsp;born&nbsp;on&nbsp;2/22/26&nbsp;and&nbsp;at&nbsp;that&nbsp;time&nbsp;Ms.&nbsp;Gross&nbsp;had&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Ms.&nbsp;Gross&nbsp;had&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Amira&#39;s&nbsp;cord&nbsp;results&nbsp;came&nbsp;back&nbsp;on&nbsp;3/3/26&nbsp;testing&nbsp;positive&nbsp;for&nbsp;cocaine&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;The&nbsp;concerns&nbsp;which&nbsp;had&nbsp;been&nbsp;reported&nbsp;on&nbsp;2/23/26&nbsp;are&nbsp;as&nbsp;follows:</p><p></p><p>Reporter&nbsp;stated&nbsp;mom&nbsp;gave&nbsp;birth&nbsp;yesterday&nbsp;and,&nbsp;although&nbsp;the&nbsp;cord&nbsp;results&nbsp;are&nbsp;not&nbsp;back&nbsp;yet,&nbsp;there&nbsp;are&nbsp;a&nbsp;lot&nbsp;of&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mom&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;mother&nbsp;denied&nbsp;using&nbsp;buprenorphine,&nbsp;although&nbsp;has&nbsp;a&nbsp;prescription&nbsp;through&nbsp;Black&nbsp;Rock,&nbsp;but&nbsp;it&nbsp;was&nbsp;confirmed&nbsp;she&nbsp;hadn&#39;t&nbsp;picked&nbsp;it&nbsp;up&nbsp;since&nbsp;1/21/26,&nbsp;claiming&nbsp;her&nbsp;boyfriend&nbsp;had&nbsp;stolen&nbsp;it.&nbsp;</p><p></p><p>Reporter&nbsp;stated&nbsp;mother&nbsp;is&nbsp;going&nbsp;through&nbsp;extensive&nbsp;withdrawal&nbsp;and&nbsp;they&nbsp;are&nbsp;concerned&nbsp;that&nbsp;mom&nbsp;can&#39;t&nbsp;stay&nbsp;awake&nbsp;long&nbsp;enough&nbsp;to&nbsp;perform&nbsp;any&nbsp;care&nbsp;for&nbsp;the&nbsp;baby.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;a&nbsp;nurse&nbsp;was&nbsp;at&nbsp;bedside&nbsp;to&nbsp;help&nbsp;feed&nbsp;the&nbsp;baby&nbsp;and&nbsp;mom&nbsp;kept&nbsp;dosing&nbsp;off&nbsp;and&nbsp;falling&nbsp;asleep.&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;keeps&nbsp;asking&nbsp;for&nbsp;help&nbsp;to&nbsp;feed&nbsp;the&nbsp;baby&nbsp;her&nbsp;bottle&nbsp;and&nbsp;has&nbsp;thrown&nbsp;up&nbsp;while&nbsp;feeding.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;has&nbsp;acknowledged&nbsp;that&nbsp;she&nbsp;should&nbsp;not&nbsp;be&nbsp;alone&nbsp;with&nbsp;the&nbsp;baby.&nbsp;&nbsp;Baby&nbsp;is&nbsp;currently&nbsp;in&nbsp;the&nbsp;nursery&nbsp;due&nbsp;to&nbsp;those&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;Ms.&nbsp;Gross&nbsp;has&nbsp;her&nbsp;mother,&nbsp;Mary&nbsp;Whorton,&nbsp;301.988.1093,&nbsp;listed&nbsp;as&nbsp;an&nbsp;emergency&nbsp;contact,&nbsp;however,&nbsp;on&nbsp;1/27/26&nbsp;provided&nbsp;a&nbsp;statement&nbsp;that&nbsp;no&nbsp;information&nbsp;should&nbsp;be&nbsp;given&nbsp;except&nbsp;to&nbsp;her&nbsp;sister,&nbsp;Crystal&nbsp;Rogers&nbsp;(Gross.)&nbsp;Mother&nbsp;advised&nbsp;she&nbsp;resides&nbsp;alone&nbsp;with&nbsp;her&nbsp;two&nbsp;other&nbsp;children.&nbsp;</p><p></p></p><p><strong>Addendum: The ROH/CI intake (I261013914968) narrative was updated, and Caregiver Impairment was selected to support the agencys appropriate response and ensure all relevant information is captured.
 </strong></p>')
	),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013976217' and activeflag = 1;

--Updating jsondata in intakedastatus

update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><strong>FYI&#39;s&nbsp;to&nbsp;worker,&nbsp;ShellyAnn&nbsp;Smallwood,&nbsp;her&nbsp;supervisor,&nbsp;and&nbsp;PM</strong></p><p></p><p>Amira&nbsp;was&nbsp;born&nbsp;on&nbsp;2/22/26&nbsp;and&nbsp;at&nbsp;that&nbsp;time&nbsp;Ms.&nbsp;Gross&nbsp;had&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Ms.&nbsp;Gross&nbsp;had&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Amira&#39;s&nbsp;cord&nbsp;results&nbsp;came&nbsp;back&nbsp;on&nbsp;3/3/26&nbsp;testing&nbsp;positive&nbsp;for&nbsp;cocaine&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;The&nbsp;concerns&nbsp;which&nbsp;had&nbsp;been&nbsp;reported&nbsp;on&nbsp;2/23/26&nbsp;are&nbsp;as&nbsp;follows:</p><p></p><p>Reporter&nbsp;stated&nbsp;mom&nbsp;gave&nbsp;birth&nbsp;yesterday&nbsp;and,&nbsp;although&nbsp;the&nbsp;cord&nbsp;results&nbsp;are&nbsp;not&nbsp;back&nbsp;yet,&nbsp;there&nbsp;are&nbsp;a&nbsp;lot&nbsp;of&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mom&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;mother&nbsp;denied&nbsp;using&nbsp;buprenorphine,&nbsp;although&nbsp;has&nbsp;a&nbsp;prescription&nbsp;through&nbsp;Black&nbsp;Rock,&nbsp;but&nbsp;it&nbsp;was&nbsp;confirmed&nbsp;she&nbsp;hadn&#39;t&nbsp;picked&nbsp;it&nbsp;up&nbsp;since&nbsp;1/21/26,&nbsp;claiming&nbsp;her&nbsp;boyfriend&nbsp;had&nbsp;stolen&nbsp;it.&nbsp;</p><p></p><p>Reporter&nbsp;stated&nbsp;mother&nbsp;is&nbsp;going&nbsp;through&nbsp;extensive&nbsp;withdrawal&nbsp;and&nbsp;they&nbsp;are&nbsp;concerned&nbsp;that&nbsp;mom&nbsp;can&#39;t&nbsp;stay&nbsp;awake&nbsp;long&nbsp;enough&nbsp;to&nbsp;perform&nbsp;any&nbsp;care&nbsp;for&nbsp;the&nbsp;baby.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;a&nbsp;nurse&nbsp;was&nbsp;at&nbsp;bedside&nbsp;to&nbsp;help&nbsp;feed&nbsp;the&nbsp;baby&nbsp;and&nbsp;mom&nbsp;kept&nbsp;dosing&nbsp;off&nbsp;and&nbsp;falling&nbsp;asleep.&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;keeps&nbsp;asking&nbsp;for&nbsp;help&nbsp;to&nbsp;feed&nbsp;the&nbsp;baby&nbsp;her&nbsp;bottle&nbsp;and&nbsp;has&nbsp;thrown&nbsp;up&nbsp;while&nbsp;feeding.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;has&nbsp;acknowledged&nbsp;that&nbsp;she&nbsp;should&nbsp;not&nbsp;be&nbsp;alone&nbsp;with&nbsp;the&nbsp;baby.&nbsp;&nbsp;Baby&nbsp;is&nbsp;currently&nbsp;in&nbsp;the&nbsp;nursery&nbsp;due&nbsp;to&nbsp;those&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;Ms.&nbsp;Gross&nbsp;has&nbsp;her&nbsp;mother,&nbsp;Mary&nbsp;Whorton,&nbsp;301.988.1093,&nbsp;listed&nbsp;as&nbsp;an&nbsp;emergency&nbsp;contact,&nbsp;however,&nbsp;on&nbsp;1/27/26&nbsp;provided&nbsp;a&nbsp;statement&nbsp;that&nbsp;no&nbsp;information&nbsp;should&nbsp;be&nbsp;given&nbsp;except&nbsp;to&nbsp;her&nbsp;sister,&nbsp;Crystal&nbsp;Rogers&nbsp;(Gross.)&nbsp;Mother&nbsp;advised&nbsp;she&nbsp;resides&nbsp;alone&nbsp;with&nbsp;her&nbsp;two&nbsp;other&nbsp;children.&nbsp;</p><p></p></p><p><strong>Addendum: The ROH/CI intake (I261013914968) narrative was updated, and Caregiver Impairment was selected to support the agencys appropriate response and ensure all relevant information is captured.
 </strong></p>')
	),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013976217' and activeflag = 1;

--Updating jsondata in intakesnapshot
update intakesnapshot
set jsondata = jsonb_set(jsondata, '{General, Narrative}',
	to_jsonb(jsondata->'General'->>'Narrative' || '<p><strong>FYI&#39;s&nbsp;to&nbsp;worker,&nbsp;ShellyAnn&nbsp;Smallwood,&nbsp;her&nbsp;supervisor,&nbsp;and&nbsp;PM</strong></p><p></p><p>Amira&nbsp;was&nbsp;born&nbsp;on&nbsp;2/22/26&nbsp;and&nbsp;at&nbsp;that&nbsp;time&nbsp;Ms.&nbsp;Gross&nbsp;had&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Ms.&nbsp;Gross&nbsp;had&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Amira&#39;s&nbsp;cord&nbsp;results&nbsp;came&nbsp;back&nbsp;on&nbsp;3/3/26&nbsp;testing&nbsp;positive&nbsp;for&nbsp;cocaine&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;The&nbsp;concerns&nbsp;which&nbsp;had&nbsp;been&nbsp;reported&nbsp;on&nbsp;2/23/26&nbsp;are&nbsp;as&nbsp;follows:</p><p></p><p>Reporter&nbsp;stated&nbsp;mom&nbsp;gave&nbsp;birth&nbsp;yesterday&nbsp;and,&nbsp;although&nbsp;the&nbsp;cord&nbsp;results&nbsp;are&nbsp;not&nbsp;back&nbsp;yet,&nbsp;there&nbsp;are&nbsp;a&nbsp;lot&nbsp;of&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;tested&nbsp;positive&nbsp;for&nbsp;buprenorphine,&nbsp;cocaine,&nbsp;and&nbsp;fentanyl.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mom&nbsp;also&nbsp;self&nbsp;reported&nbsp;that&nbsp;she&nbsp;used&nbsp;heroin&nbsp;the&nbsp;morning&nbsp;she&nbsp;came&nbsp;to&nbsp;deliver,&nbsp;however&nbsp;did&nbsp;not&nbsp;test&nbsp;positive&nbsp;for&nbsp;heroin.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;mother&nbsp;denied&nbsp;using&nbsp;buprenorphine,&nbsp;although&nbsp;has&nbsp;a&nbsp;prescription&nbsp;through&nbsp;Black&nbsp;Rock,&nbsp;but&nbsp;it&nbsp;was&nbsp;confirmed&nbsp;she&nbsp;hadn&#39;t&nbsp;picked&nbsp;it&nbsp;up&nbsp;since&nbsp;1/21/26,&nbsp;claiming&nbsp;her&nbsp;boyfriend&nbsp;had&nbsp;stolen&nbsp;it.&nbsp;</p><p></p><p>Reporter&nbsp;stated&nbsp;mother&nbsp;is&nbsp;going&nbsp;through&nbsp;extensive&nbsp;withdrawal&nbsp;and&nbsp;they&nbsp;are&nbsp;concerned&nbsp;that&nbsp;mom&nbsp;can&#39;t&nbsp;stay&nbsp;awake&nbsp;long&nbsp;enough&nbsp;to&nbsp;perform&nbsp;any&nbsp;care&nbsp;for&nbsp;the&nbsp;baby.&nbsp;&nbsp;Reporter&nbsp;advised&nbsp;a&nbsp;nurse&nbsp;was&nbsp;at&nbsp;bedside&nbsp;to&nbsp;help&nbsp;feed&nbsp;the&nbsp;baby&nbsp;and&nbsp;mom&nbsp;kept&nbsp;dosing&nbsp;off&nbsp;and&nbsp;falling&nbsp;asleep.&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;keeps&nbsp;asking&nbsp;for&nbsp;help&nbsp;to&nbsp;feed&nbsp;the&nbsp;baby&nbsp;her&nbsp;bottle&nbsp;and&nbsp;has&nbsp;thrown&nbsp;up&nbsp;while&nbsp;feeding.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;mother&nbsp;has&nbsp;acknowledged&nbsp;that&nbsp;she&nbsp;should&nbsp;not&nbsp;be&nbsp;alone&nbsp;with&nbsp;the&nbsp;baby.&nbsp;&nbsp;Baby&nbsp;is&nbsp;currently&nbsp;in&nbsp;the&nbsp;nursery&nbsp;due&nbsp;to&nbsp;those&nbsp;concerns.&nbsp;&nbsp;Reporter&nbsp;stated&nbsp;Ms.&nbsp;Gross&nbsp;has&nbsp;her&nbsp;mother,&nbsp;Mary&nbsp;Whorton,&nbsp;301.988.1093,&nbsp;listed&nbsp;as&nbsp;an&nbsp;emergency&nbsp;contact,&nbsp;however,&nbsp;on&nbsp;1/27/26&nbsp;provided&nbsp;a&nbsp;statement&nbsp;that&nbsp;no&nbsp;information&nbsp;should&nbsp;be&nbsp;given&nbsp;except&nbsp;to&nbsp;her&nbsp;sister,&nbsp;Crystal&nbsp;Rogers&nbsp;(Gross.)&nbsp;Mother&nbsp;advised&nbsp;she&nbsp;resides&nbsp;alone&nbsp;with&nbsp;her&nbsp;two&nbsp;other&nbsp;children.&nbsp;</p><p></p></p><p><strong>Addendum: The ROH/CI intake (I261013914968) narrative was updated, and Caregiver Impairment was selected to support the agencys appropriate response and ensure all relevant information is captured.
 </strong></p>')
	),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013976217' and activeflag = 1;

/*
4. intake # I261013976217
Add the Maltreatment type - Child's basic needs are likely to be unmet due to caregiver impairment(SDM changes should reflect in the case)
*/


--Updating in intakedastaging
update intakedastaging
set
	 jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_basicneedsunmet}', 'true')),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013976217' and activeflag = 1;

--Updating in intakesnapshot
update intakesnapshot
set
    jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_basicneedsunmet}', 'true')),
	updatedby = 'CJAMS-66721', updatedon = now()
where intakenumber = 'I261013976217' and activeflag = 1;

update intakeservicerequestsdm 
set isnegrh_basicneedsunmet = 'true'
    , updatedby = 'CJAMS-66721'
    , updatedon = now()
where intakeserviceid ='2bcb7a74-a51f-4841-853a-e431e067b804' and activeflag = 1;
