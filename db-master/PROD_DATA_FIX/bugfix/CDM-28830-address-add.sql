/*
   Issue Description: CDM-28830
   Category/ Module  :  Address add
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO personaddress(
		personid, activeflag,personaddresstypekey,
		address,  zipcode, city, state, county,
		insertedby, insertedon, updatedby, updatedon, 
		effectivedate,expirationdate, currentlocationflag, addressstartdate)
		values
		('a13d302d-72ba-4e07-8346-4dc7efb881c5',1, 'HO', 
		'34 Rumelia Circle', '21221', 'Essex','MD', 'USA',
		'CDM-28830', now(),'CDM-28830', now(),
		now(),null, 1, now());