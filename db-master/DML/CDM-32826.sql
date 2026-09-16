/*
   Issue Description: CDM-32826
   Category/ Module  : Approval Inbox
   Root cause: user wants to delete the record form pending approval tab
   Case Number: 3220259, 202108506852, 3160268
   Pull request# for data fix: 
   Reason why no related code fix: 
   Description: Dashboard:Cases in my approval box The cases appear for approval and nothing is in approval status once the case is review. 
   The request is for case plan review and everything is approval however the items is still in my in box for approval (case name). 
   Can this issues be resolved to clear approval box. Screen URL:
*/

-- inspect the page u will get object id from that you will get routing id

select distinct routingid from routing where objectid = 'd7dd1228-5357-4ceb-8d27-7c2a3e3cb172' and activeflag=1;
update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '6b86ba57-6ad5-4801-bf3b-924eab760726';

select distinct routingid from routing where objectid = '04072cc3-b0a5-4af4-897f-56f69652f596' and activeflag=1;
update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = 'b3cd568d-02b2-4fb9-80db-ef42f7f7f7a7';
	
select distinct routingid from routing where objectid = '33c2b0f7-f39e-4c7c-9409-fdc2796615f9' and activeflag=1;
update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = 'e87c4517-561a-4296-9df5-2fc19562207b';

select distinct routingid from routing where objectid = 'a8573763-57df-4873-af83-890e18b5c402' and activeflag=1;
update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '1e221d58-5767-4a0b-b45c-03a3778c96c8';

select distinct routingid from routing where objectid = 'baee4a8e-5b76-477c-a4e4-30222b8cc85f' and activeflag=1;
update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '11c9e538-0ed1-4baf-8a7c-9a5e94ea319c';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '12ab2f8b-df8d-458f-89c4-9cd3a3052071';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '175e1c1e-e360-4bd5-b1a9-bc9c535869aa';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '3fdaeab3-2389-4676-8dab-bc3630b95399';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '5bdea680-a2c8-494b-9a68-9b3c1e68bf1d';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '79341a81-02ad-46ab-b9ce-419c0a4af3ac';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '79c3e2ac-bfc3-4f18-91f8-132e3ed1725d';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '7dd2f436-9dcf-465f-be98-6a6dca3fd184';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = '968b9478-2f12-4934-abd9-6b22fb625039';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = 'a0ac874f-70d4-43c6-b897-f67c2e74268a';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = 'b888623e-7e27-4955-b006-7b2e8929f920';

update routing 
	set  updatedby = 'CDM-32826',updatedon = now(), activeflag = 0
	where  routingid = 'cc13dd54-002d-4462-b91c-9d32dbeb3577';