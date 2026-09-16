update intakeservicerequest
				set activeflag = 0,
				updatedon = now()
						
				where servicerequestnumber='20200132018481';
				
			update intakeservicerequestsdm
				set activeflag = 0,
				updatedon = now()
				
				where intakeserviceid = '3654dfaf-0fcc-40da-8b25-0e80bf8af411';