/*
   Issue Description: CDM-18837
   Category/ Module  : Placement history  
   Root cause: User requested to remove records
   Pull request# for code fix: 4329
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

-- issue 1
-- 1. Move the contact notes from 211020163429(November open CPS-IR) to 211020166294 (Decemebre open CPS-IR) 10+6 = 16

select progressnoteid, contactdate, entitytype, entitytypeid, activeflag, updatedby, updatedon 
	from progressnote 
where entitytypeid = 'a61e892d-5d99-4e42-ac59-5ffcaba1b985' -- 211020163429 
	and activeflag = 1 ;
	
update progressnote
set entitytypeid = '81002362-77a3-4d99-acda-320dc58c2131', -- 211020166294
	updatedby = 'CDM-18837',
	updatedon = now()
where entitytypeid = 'a61e892d-5d99-4e42-ac59-5ffcaba1b985' -- 211020163429
	and activeflag = 1 ;

---- 1. Move the contact notes from 211020163429(November open CPS-IR) to 211020166294 (Decemebre open CPS-IR) 10+6 = 16
   select progressnoteid, contactdate, entitytype, entitytypeid, activeflag, updatedby, updatedon 
	from progressnote 
where entitytypeid = '660230f3-f38d-4607-ad26-82e34ec2eb88' -- 211020163429 
	and activeflag = 1 ;
	
update progressnote
set entitytypeid = '81002362-77a3-4d99-acda-320dc58c2131', -- 211020166294
	updatedby = 'CDM-18837',
	updatedon = now()
where entitytypeid = '660230f3-f38d-4607-ad26-82e34ec2eb88' -- 211020163429
	and activeflag = 1 ;


---issue 2
--Change the associated referral number I211010217297 - Change to Scrrenout
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-18837', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010217297' AND activeflag=1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-18837', updatedon = now() 
where intakenumber = 'I211010217297';

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-18837', updatedon = now()
where intakenumber = 'I211010217297' and activeflag = 1;
	
update intakedastatus 
set status = 8, updatedby = 'CDM-18837', updatedon = now()
where intakenumber = 'I211010217297' and activeflag = 1;

---issue 3
--Delete CPS IR- 211020163429 (nov Open)
update intakeservicerequest set activeflag =0 , updatedby = 'CDM-18837', updatedon = now() where intakeserviceid ='a61e892d-5d99-4e42-ac59-5ffcaba1b985';

update routing set activeflag =0 , updatedby = 'CDM-17896', updatedon = now() where routingid in ('e9863118-b2e8-43b5-b15e-d8fc890438ef',
'9fddd02f-302a-47b2-b2df-30281593aef9');


---issue 4
---Connect Intake I211010220647(dec open) with Service case 211030012619

select * from createservicecase('81002362-77a3-4d99-acda-320dc58c2131',
'660230f3-f38d-4607-ad26-82e34ec2eb88',0,'309d6683-8cbe-4d52-8c6f-7035bc0f1db9');
