/*
   Issue Description: CDM-43198
   SSA is approved on 01/13/2025 to remove the respective person from the contact note on CPS IR case # 241022958387.
    Contact ID: 14652096
    Client ID: 200938876 (CHRISTOPHER MICHAEL MCCOY)
   Category/ Module  : contact notes
   Root cause: user want to update data in contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select activeflag,updatedby,* from contactparticipant where contactparticipantid = '08ff31b6-8db3-41cb-a082-9f7ea75103b7';
*/

update contactparticipant
set activeflag = 0,
	updatedby = 'CDM-43198',
	updatedon = now()
where contactparticipantid = '08ff31b6-8db3-41cb-a082-9f7ea75103b7'
	and activeflag = 1 ;