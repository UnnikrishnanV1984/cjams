/*
   Issue Description: CDM-32040
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--de18377b-d6d6-46fe-a302-72976bac7885
--4896f110-8c4a-43b8-9bd0-622325bf49c3
update documentproperties set insertedby = '7fa341da-4746-46af-af86-dfe9cfed7342', updatedby = 'CDM-32040', updatedon = now()
where documentpropertiesid in ('fb93d301-6f0e-46b6-988f-f1aee2b7e903',
'c009b561-9269-409a-9632-853c8956418b');


--de18377b-d6d6-46fe-a302-72976bac7885
--4896f110-8c4a-43b8-9bd0-622325bf49c3
update documentattachment set insertedby = '7fa341da-4746-46af-af86-dfe9cfed7342', updatedby = 'CDM-32040', updatedon = now()
where documentpropertiesid in ('fb93d301-6f0e-46b6-988f-f1aee2b7e903',
'c009b561-9269-409a-9632-853c8956418b');