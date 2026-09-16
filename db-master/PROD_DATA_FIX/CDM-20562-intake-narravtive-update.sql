
/*
   Issue Description: CDM-20562
   Category/ Module  : Intake
   Root cause: user requeseted to update the intake narrative and history clearance content
*/

update intakedastaging
set updatedby = 'CDM-20562',
    updatedon = now(),
    jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(
                    select jsonb(jsondata->>'General')-'Narrative' || jsonb(json_build_object('Narrative', '<p>Ms. Jaimes was found responsible for neglect May 2007 Indicated finding.') )
                    from intakedastaging i 
                    where intakenumber = 'I221010242155' and activeflag = 1))
                ) from intakedastaging i2
                where intakenumber = 'I221010242155' and activeflag = 1)
where intakenumber = 'I221010242155' and activeflag = 1;

update intakesnapshot
set updatedby = 'CDM-20562',
    updatedon = now(),
    jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'Narrative' || jsonb(json_build_object('Narrative','<p>Ms. Jaimes was found responsible for neglect May 2007 Indicated finding.') )
                from intakesnapshot i 
                where intakenumber = 'I221010242155' and activeflag = 1)))
                from intakesnapshot i2
                where intakenumber = 'I221010242155' and activeflag = 1)
where intakenumber = 'I221010242155' and activeflag = 1;
    

update intakedastaging
set updatedby = 'CDM-20562',
    updatedon = now(),
    jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(
                    select jsonb(jsondata->>'General')-'cpsHistoryClearance' || jsonb(json_build_object('cpsHistoryClearance', '<p>Ms. Jaimes was found responsible for neglect May 2007 Indicated finding.') )
                    from intakedastaging i 
                    where intakenumber = 'I221010242155' and activeflag = 1))
                ) from intakedastaging i2
                where intakenumber = 'I221010242155' and activeflag = 1)
where intakenumber = 'I221010242155' and activeflag = 1;

update intakesnapshot
set updatedby = 'CDM-20562',
    updatedon = now(),
    jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'cpsHistoryClearance' || jsonb(json_build_object('cpsHistoryClearance','<p>Ms. Jaimes was found responsible for neglect May 2007 Indicated finding.') )
                from intakesnapshot i 
                where intakenumber = 'I221010242155' and activeflag = 1)))
                from intakesnapshot i2
                where intakenumber = 'I221010242155' and activeflag = 1)
where intakenumber = 'I221010242155' and activeflag = 1;
    
