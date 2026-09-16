-- CDM-11045 - Remove referral

update intakedastaging set activeflag =0, updatedby = 'CDM-11045', updatedon = now() where intakenumber ='I202100129652' and activeflag =1; 
update intakedastatus set activeflag =0, updatedby = 'CDM-11045', updatedon = now() where intakenumber ='I202100129652' and activeflag =1; 
