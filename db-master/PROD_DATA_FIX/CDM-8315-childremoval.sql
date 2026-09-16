			update cjams.routing
			set activeflag = 0
			where routingid = 'e2a9bb6b-a2f2-48c2-979b-a3061d066921';
		
			update cjams.intakeservreqchildremoval
			set exitdate = null
			where intakeservreqchildremovalid = '9b1d56a0-4302-4b19-be98-47cb735ca757';