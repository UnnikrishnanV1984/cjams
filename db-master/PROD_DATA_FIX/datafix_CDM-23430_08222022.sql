/*
   Issue Description: CDM-23430
   Category/ Module  : remove review request from service case 3258698 and approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag = 0, updatedby = 'CDM-23430', updatedon = now() where objectid  = '7b6d69e1-22ec-4363-993e-12ac6d528e85' and servicerequestnumber  = '3258698' and eventcode ='GARR' and activeflag = 1;
update gapratesrevision set activeflag = 0, updatedby = 'CDM-23430', updatedon = now() where gaprateid ='7b6d69e1-22ec-4363-993e-12ac6d528e85' ;
update gapagreementrate set activeflag = 0, updatedby = 'CDM-23430', updatedon = now() where gapagreementrateid = '7b6d69e1-22ec-4363-993e-12ac6d528e85';
