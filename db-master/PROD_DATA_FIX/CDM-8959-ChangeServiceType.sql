-- CDM-8959 - Change Service type and subtype in Summary page

update intakeservicerequest set intakeservreqtypeid = 'd207bdd4-f281-4ec8-949c-8fd9657227f9', intakeservicerequestclassid = '49984266-b51b-42da-b074-8c9a8a475156', updatedby = 'CDM-8959', updatedon = now() where intakenumber ='I202000064285' and intakeserviceid = '3973e2a5-5828-487c-9b00-cbc7816319fc';