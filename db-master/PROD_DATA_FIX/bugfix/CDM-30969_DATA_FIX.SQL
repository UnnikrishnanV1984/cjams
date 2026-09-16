/*
  Issue Description: CDM-30969
   Category/ Module  : deleting the user actions on permenancy plan 
   Root cause: user wants to delete permanancy plan history
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
DELETE  FROM permanencyplanhistory WHERE  permanencyplanhistoryid='74ddd59e-987c-43b0-9f91-a0de402a7000';
DELETE  FROM permanencyplanhistory WHERE  permanencyplanhistoryid='5e5b29ef-154a-49ca-a76d-476bf00e5aab';
update permanencyplan set enddate=null,achieveddate=null,updatedby='CDM-30969',updatedon=now() where permanencyplanid='81db6ee6-77dd-4986-9737-dbfbf6aa376a';
update routing set activeflag=0,updatedby='CDM-30969',updatedon=now() where objectid='81db6ee6-77dd-4986-9737-dbfbf6aa376a'
and routingstatustypeid=17;


DELETE  FROM permanencyplanhistory WHERE  permanencyplanhistoryid='a55c416a-3355-4425-8521-65fa5a0af26d';
DELETE  FROM permanencyplanhistory WHERE  permanencyplanhistoryid='86fbdab3-0354-470c-a1e8-8ee800532575';
update permanencyplan set enddate=null,achieveddate=null,updatedby='CDM-30969',updatedon=now() where permanencyplanid='bb88e880-00b4-43c1-88a8-24001730f273';
update routing set activeflag=0,updatedby='CDM-30969',updatedon=now() where objectid='bb88e880-00b4-43c1-88a8-24001730f273'
and routingstatustypeid=17;

DELETE  FROM permanencyplanhistory WHERE  permanencyplanhistoryid='9386010f-3842-42ff-a688-755145300eb5';
DELETE  FROM permanencyplanhistory WHERE  permanencyplanhistoryid='22d92ae0-9091-448f-8b62-218050f900b6';
update permanencyplan set enddate=null,achieveddate=null,updatedby='CDM-30969',updatedon=now() where permanencyplanid='c9f7d549-3d0f-4060-8794-5337079ed5d1';
update routing set activeflag=0,updatedby='CDM-30969',updatedon=now() where objectid='c9f7d549-3d0f-4060-8794-5337079ed5d1'
and routingstatustypeid=17;
