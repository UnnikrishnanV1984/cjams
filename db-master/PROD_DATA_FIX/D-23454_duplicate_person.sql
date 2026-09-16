--D-23454 duplicate person

update personidentifier set activeflag = 0, updatedon = now() 
where personidentifiertypekey='MDM_ID'
and personid in (select distinct personid from person where cjamspid = 160935 );

update person set cisclientid = null, updatedon= now() 
where cjamspid = 160935 and cisclientid = 455019845;

