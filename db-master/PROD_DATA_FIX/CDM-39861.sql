/*
 * CDM-39861 - finding of neglect 2 times
 * Customer Email ID:missy.langham@maryland.gov
 * Description - 241022368107:I'm trying to close this case and there is 2 sections for neglect. 
 * I need to delete the empty one for neglect.
 * remove the duplicate investigation findings as mentioned below.
 * 
 */
 
--select * from investigationallegation where  investigationallegationid in ('e11fc4b5-1edf-4f17-af54-b536bbf6df31') and activeflag=1;
update
   investigationallegation
set
   activeflag = 0,
   updatedby = 'CDM-39861',
   updatedon = now()
where
   investigationallegationid='e11fc4b5-1edf-4f17-af54-b536bbf6df31'::uuid  and activeflag=1;

--select activeflag,updatedby,updatedon from investigationmaltreatment where maltreatmentid ='e6b3c5ca-5589-4a91-ba2b-1240de9a7382' and activeflag=1;
update
   investigationmaltreatment
set
   activeflag = 0,
   updatedby = 'CDM-39861',
   updatedon = now()
where maltreatmentid ='e6b3c5ca-5589-4a91-ba2b-1240de9a7382' and activeflag=1;

--select activeflag, updatedby, updatedon from investigationallegationmaltreators where investigationallegationid in ('e11fc4b5-1edf-4f17-af54-b536bbf6df31') and activeflag = 1 ;
update investigationallegationmaltreators
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-39861'	
where investigationallegationid in ('e11fc4b5-1edf-4f17-af54-b536bbf6df31')
	and activeflag = 1 ;
