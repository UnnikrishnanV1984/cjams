/*
 * CDM-34701 - Nine Intake Cases MIgration
 * Customer Email ID:kimyetta.hammonholder@maryland.gov
 * Customer Name:Kimyetta HammonHolder
 * The intake worker (Shakeisha Alexander) is not working with the agency anymore and need to remove/delete all draft intakes under 
 * the worker name so it will not display under the workload.
 * intakenumber = 'I202000011645','I202000591349','I202000678619','I211010172950','I211010172277','I202100050873','I202000497449','I202000591331','I202000591302'
 */		

select * from intakedastaging where intakenumber in ('I202000011645','I202000591349','I202000678619','I211010172950','I211010172277','I202100050873','I202000497449','I202000591331','I202000591302') and activeflag=1;
select * from userprofile where securityusersid = '40ca733f-9a00-4432-9c55-cc3a20470eba';
update intakedastaging set activeflag =0, updatedby = 'CDM-34701', updatedon = now() where 
intakenumber in ('I202000011645','I202000591349','I202000678619','I211010172950','I211010172277','I202100050873','I202000497449','I202000591331','I202000591302') and activeflag =1; 
update intakedastatus set activeflag =0, updatedby = 'CDM-34701', updatedon = now() where 
intakenumber in ('I202000011645','I202000591349','I202000678619','I211010172950','I211010172277','I202100050873','I202000497449','I202000591331','I202000591302') and activeflag =1; 
