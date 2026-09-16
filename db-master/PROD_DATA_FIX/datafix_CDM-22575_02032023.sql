-- CDM-22575 - CW casework
/*
-- Issue Description: 

	Dashboard:Person was entered incorrectly. The prefix was entered as "Trooper" 
    and it will not allow to delete it. Worker was able to change the prefix to "Miss" but would 
    like the prefix to be blank with no title.



*/

select * from PERSON where lastname = 'WOOSTER' and firstname = 'Tristin' and personid = 'abe76c61-c19b-4dd5-94fc-3f64a7c69abd';

update PERSON set prefx = '',updatedby = 'CDM-22575', updatedon = now() where lastname = 'WOOSTER' and firstname = 'Tristin' and personid = 'abe76c61-c19b-4dd5-94fc-3f64a7c69abd';