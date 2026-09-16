import { Injectable } from '@angular/core';
import { ChildRemovalService } from './child-removal.service';
import moment from 'moment';

@Injectable()
export class ChildRemovalMapperService {
  invaliddt = 'Invalid date';
  constructor(private _childRemovalService: ChildRemovalService) { }
  mapChildRemovalFormData(childRemovalData: any) {
    const formatedData = childRemovalData;
    formatedData.intakeserviceid = this.getIntakeserviceid();
    formatedData.servicecaseid = this.getServicecaseid();
    const time = moment(formatedData.removaltime).format('YYYY-MM-DD HH:mm:ss');
    formatedData.removaltime = moment(time).isValid() ? time : null;
    if (formatedData.exittime && formatedData.exittime !== this.invaliddt) {
      const exittime = this.getExitTime(formatedData);
      if (formatedData.exitdate) {
        const exitDateOnly = formatedData.exitdate.substring(0, 10);
        const exitdattime = exitDateOnly + 'T' + exittime;
        formatedData.exitdate = exitdattime;
      }
    }
    formatedData.rmvdfrmisractorid = null;
    formatedData.mothername = null;
    formatedData.removalzip = '65559999';
    if (formatedData.removalreason) {
      formatedData.removalreason = formatedData.removalreason.map((reason: any) => {
        return {
          removalreasontypeid: reason,
          removalreasontypekey: reason
        };
      });
    }

    if (formatedData.caregiverreason) {
      formatedData.caregiverreason = formatedData.caregiverreason.map((reason: any) => {
        return {
          reasontypekey: reason
        };
      });
    }

    if (formatedData.reasonableefforts) {
      formatedData.reasonableefforts = formatedData.reasonableefforts.map((reason: any) => { // NOSONAR // Less than 3 lines of identical code
        return {
          reasontypekey: reason
        };
      });
    }

    if (formatedData.exitreason) {
      formatedData.exitreason = formatedData.exitreason.map((reason: any) => { // NOSONAR // Less than 3 lines of identical code
        return {
          reasontypekey: reason
        };
      });
    }
    if (formatedData.notmakingefforts) {
      formatedData.notmakingefforts = formatedData.notmakingefforts.map((reason: any) => { // NOSONAR // Less than 3 lines of identical code
        return {
          reasontypekey: reason
        };
      });
    }
    formatedData.isverifiedcaregiver1add = formatedData.isverifiedcaregiver1add ? 1 : 0;
    formatedData.isverifiedcaregiver2add = formatedData.isverifiedcaregiver2add ? 1 : 0;
    return formatedData;

  }

  getIntakeserviceid(){
    return this._childRemovalService.isServiceCase() ? null : this._childRemovalService.intakeserviceid;
  }

  getServicecaseid(){
    return this._childRemovalService.isServiceCase() ? this._childRemovalService.intakeserviceid : null;
  }
  
  getExitTime(formatedData: any){
    return moment(formatedData.exittime).isValid() ? moment(formatedData.exittime).format('HH:mm:ss') :  formatedData.exittime;
  }


  unMapChildRemovalInfo(childRemovalInfo: any) {
    const formatedData = childRemovalInfo;
    formatedData.isverifiedcaregiver1add = this.isVerifiedcaregiver1add(formatedData);
    formatedData.isverifiedcaregiver2add = this.isVerifiedcaregiver2add(formatedData);
    formatedData.removaltime= this.getRemovaltime(formatedData);
    formatedData.exittime= this.getExitTime(formatedData);

    if (formatedData.removalreason) {
      formatedData.removalreason = formatedData.removalreason.map((reason: any) => {
        return this.getremovalreasontypekey(reason);
      });
    }
    if (formatedData.caregiverreason) {
      formatedData.caregiverreason = formatedData.caregiverreason.map((reason: any) => {
        return this.getremovalreasontypekey(reason);
      });
    }

    if (formatedData.reasonableefforts) {
      formatedData.reasonableefforts = formatedData.reasonableefforts.map((reason: any) => {
        return this.getremovalreasontypekey(reason);
      });
    }
    if (formatedData.notmakingefforts) {
      formatedData.notmakingefforts = formatedData.notmakingefforts.map((reason: any) => {
        return this.getremovalreasontypekey(reason);
      });
    }
    if (formatedData.exitreason) {
      formatedData.exitreason = formatedData.exitreason.map((reason: any) => {
        return this.getremovalreasontypekey(reason);
      });
    }
    return formatedData;
  }

  isVerifiedcaregiver1add(formatedData: any){
    return formatedData.isverifiedcaregiver1add ? true : false;
  }
  isVerifiedcaregiver2add(formatedData: any){
    return formatedData.isverifiedcaregiver2add ? true : false;
  }
  getRemovaltime(formatedData: any){
    if (formatedData.removaltime && formatedData.removaltime !== this.invaliddt) {
      formatedData.removaltime = moment(formatedData.removaltime).isValid() ? moment(formatedData.removaltime) :  formatedData.removaltime;
    }
    return formatedData.removaltime;
  }
  getExittime(formatedData: any){
    if (formatedData.exitdate && formatedData.exitdate !== this.invaliddt) {
      formatedData.exittime = moment(formatedData.exitdate).isValid() ? moment(formatedData.exitdate).format('h:mm a') :  formatedData.exitdate;
    }
    return formatedData.exittime;
  }
  getremovalreasontypekey(reason: any){
    return reason.hasOwnProperty('removalreasontypekey') ? reason.removalreasontypekey : reason;
  }
  
}
