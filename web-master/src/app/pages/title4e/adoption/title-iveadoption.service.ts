import { Injectable } from '@angular/core';
import { Subject , BehaviorSubject} from 'rxjs';

const KEYS = {
  'AdoptionApplicable': 'AdoptionApplicable',
  'AdoptionDataIncomplete': 'AdoptionDataIncomplete',
  'AdoptionNonApplicable': 'AdoptionNonApplicable',
  'EXTAdoption': 'EXTAdoption',
  'AdoptionAssistance': 'AdoptionAssistance'
};
const adoptionapplicable = 'Adoption Applicable';
@Injectable()
export class TitleIveadoptionService {

    public fileuploadcompleted = new BehaviorSubject<null|Boolean>(null);

  eligibility = {
    description: 'AdoptionApplicable',
    status: 'YES',
    action: ''
  };
  public adoptionSubject$ = new Subject<any>();

    uploadCompleted() {
        this.fileuploadcompleted.next(true);
    }

  processAdoptionACAD(corticonResponse:any) {
    const status = this.getAdoptionStatusObject(corticonResponse);
    if (status.hasOwnProperty(KEYS.AdoptionApplicable)) {
      this.eligibility.description = adoptionapplicable;
      this.eligibility.status = status[KEYS.AdoptionApplicable];
    }
    if (status.hasOwnProperty(KEYS.AdoptionDataIncomplete)) {
      this.eligibility.description = 'Adoption Data Incomplete';
      this.eligibility.status = status[KEYS.AdoptionDataIncomplete];
    }
    if (status.hasOwnProperty(KEYS.AdoptionNonApplicable)) {
      this.eligibility.description = 'Adoption Non Applicable';
      this.eligibility.status = status[KEYS.AdoptionNonApplicable];
    }
    this.eligibility.action = 'ACAD';
    this.publishAdoptionEligibility();


  }

  processAdoptionID(corticonResponse:any) {
    const status = this.getAdoptionStatusObject(corticonResponse);
    if (status.hasOwnProperty(KEYS.AdoptionApplicable)) {
      this.eligibility.description = adoptionapplicable;
      this.eligibility.status = status[KEYS.AdoptionApplicable];
    }
    if (status.hasOwnProperty(KEYS.AdoptionAssistance)) {
      this.eligibility.description = 'Adoption Assistance';
      this.eligibility.status = status[KEYS.AdoptionAssistance];
    }
    if (status.hasOwnProperty(KEYS.AdoptionNonApplicable)) {
      this.eligibility.description = 'Adoption Non Applicable';
      this.eligibility.status = status[KEYS.AdoptionNonApplicable];
    }
    this.eligibility.action = 'ID';
    this.publishAdoptionEligibility();


  }

  processAdoptionRD(corticonResponse:any) {
    const status = this.getAdoptionStatusObject(corticonResponse);
    if (status.hasOwnProperty(KEYS.AdoptionApplicable)) {
      this.eligibility.description = adoptionapplicable;
      this.eligibility.status = status[KEYS.AdoptionApplicable];
    }
    if (status.hasOwnProperty(KEYS.EXTAdoption)) {
      this.eligibility.description = 'EXT Adoption';
      this.eligibility.status = status[KEYS.EXTAdoption];
    }
    this.eligibility.action = 'RD';
    this.publishAdoptionEligibility();


  }
  getAdoptionStatusObject(corticonResponse:any) {
    let status = null;
    if (corticonResponse && corticonResponse.hasOwnProperty('Objects')) {
      const objs = corticonResponse.Objects;
      if (objs && Array.isArray(objs) && objs.length > 0) {
        status = objs[0].status;
      }
    }
    return status;
  }

  publishAdoptionEligibility() {
    (<any>$('#eligibilityTab')).click();
    this.adoptionSubject$.next('ELIGIBILITY_UPDATED');
  }

}
