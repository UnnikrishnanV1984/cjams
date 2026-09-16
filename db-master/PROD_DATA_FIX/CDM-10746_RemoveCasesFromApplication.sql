-- CDM-10746 - Remove the cases from the application

update intakeservicerequest set activeflag =0, updatedby = 'CDM-10746', updatedon =now() where intakenumber in ('CW10274787','CW10274811','CW10268655','CW19225763') and activeflag =1;
update intakedastaging set activeflag =0, updatedby = 'CDM-10746', updatedon =now() where intakenumber in ('CW10274787','CW10274811','CW10268655','CW19225763') and activeflag =1;
update intakedastatus set activeflag =0, updatedby = 'CDM-10746', updatedon =now() where intakenumber in ('CW10274787','CW10274811','CW10268655','CW19225763') and activeflag =1;
