/*
   Issue Description: CDM-31472
   Category/ Module  : 
   Root cause: user wants Change the wrong exit date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
			update placementrevision set Justification='Child reunited with Mother.',updatedon = now(), 
	updatedby = 'CDM-31472' where placementrevisionid='501a3718-01af-4830-bcc5-a1612b77ccd8' ;

			update placementrevision set Justification='Child reunited with Mother.',updatedon = now(), 
	updatedby = 'CDM-31472' where placementrevisionid='ad787f91-b5df-4721-a7b1-9d70c096a92e';

			update placement set enddatetime='2023-05-08 00:00:00' , endtime='09:00',exittypekey='PLCC',exitreasontypekey='REUNIF', remarks='Child reunited with parent.',updatedon = now(), 
	updatedby = 'CDM-31472' where placementid='6d34759c-acc3-4e2c-9e35-113e6689619e';
			
			
			update placementrevision set Justification='Child reunited with Mother.',updatedon = now(), 
	updatedby = 'CDM-31472' where placementrevisionid='5671f8ea-525c-450c-a837-5766c1acb31d' ;

			update placementrevision set Justification='Child reunited with Mother.',updatedon = now(), 
	updatedby = 'CDM-31472' where placementrevisionid='12042f05-7f1a-48a9-9218-76927b5e8359';

			update placement set enddatetime='2023-05-08 00:00:00' , endtime='09:00',exittypekey='PLCC',exitreasontypekey='REUNIF', remarks='Child reunited with parent.',updatedon = now(), 
	updatedby = 'CDM-31472' where placementid='66a9b944-d425-4677-b630-805289b3d99c';
    
    
    update tb_placement_validation set  placement_exit_dt='2023-05-08 00:00:00', update_user_id='CDM-31472', update_ts=now()  where placement_id = 1647634;
			
		
