
/*
   Issue Description: CDM-25725
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- These all records are in review that's why it was showing but theses all cases closed so user is requesting to removal all these records

-- Updatedby                             Routingid                            updatedon 

-- c8281444-79ab-4ac8-87ff-63856b986a77  c7862cf4-8f7e-44d6-ae63-627349d73a62 2022-03-17 13:58:15

--c8281444-79ab-4ac8-87ff-63856b986a77  6146c1d5-a3db-4292-ab58-b8d28dd97dd8  2022-05-20 12:03:53

--303f7300-613a-488a-bea0-d7fd382ab705  00f08b53-ed4b-4f98-86b4-0e97caab2941 2022-09-30 09:42:27

update cjams.routing set activeflag =0, updatedby ='CDM-25725', updatedon = now ()
where routingid in('c7862cf4-8f7e-44d6-ae63-627349d73a62','6146c1d5-a3db-4292-ab58-b8d28dd97dd8','00f08b53-ed4b-4f98-86b4-0e97caab2941');