import { Injectable } from '@angular/core';

@Injectable()
export class PersonExaminationService {

  getNewAppointment() {
    return {
      apptkept : null,
      apptDate: null,
      nextApptDate: null,
      natureofexamkey: null,
      isAnnualHealthVisit: null,
      isSemiAnnualDentalVisit: null,
      labtestkey: null,
      specialityexamkey: null,
      hivtestreceived: null,
      nextappointmentreason: null,
      notkeptreason: null,
      timeframe:null,
      authformcompletion:null,
      provcaremissed:null,
      notcompletedauthform:null,
      other:null,
    };
  }

}