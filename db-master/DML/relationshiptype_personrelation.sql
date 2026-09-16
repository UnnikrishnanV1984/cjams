update relationshiptype rt set personrelationship = false , updatedby = 'CDM-19950' , updatedon = now()
WHERE activeflag = 1 and fourerelid = 1015 and fourereldesc = 'Non-Relative';