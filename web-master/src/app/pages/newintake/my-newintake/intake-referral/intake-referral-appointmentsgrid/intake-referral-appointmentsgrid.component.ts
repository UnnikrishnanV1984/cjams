
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { RoutingUser } from '../../../../cjams-dashboard/_entities/dashBoard-datamodel';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { NewUrlConfig } from '../../../newintake-url.config';
import { InvolvedPerson } from '../../_entities/newintakeModel';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { IntakeAppointment } from '../../_entities/newintakeSaveModel';
import { AppConstants } from '../../../../../@core/common/constants';

@Component({
    selector: 'intake-referral-appointmentsgrid',
    templateUrl: './intake-referral-appointmentsgrid.component.html',
    styleUrls: ['./intake-referral-appointmentsgrid.component.scss'],
    standalone: false
})
export class IntakeReferralAppointmentsgridComponent implements OnInit {

  intakeWorkerList: RoutingUser[] = [];
  addedPersons: InvolvedPerson[] = [];
  appointments: IntakeAppointment[] = [];
  store: any;
  constructor(private _commonHttpService: CommonHttpService, private _store: DataStoreService) {
    this.store = this._store.getCurrentStore();
  }

  ngOnInit() {
    this.loadIntakeWorkers();
    this.appointments = this.store[IntakeStoreConstants.intakeappointment] ? this.store[IntakeStoreConstants.intakeappointment] : [];
    this.addedPersons = this.store[IntakeStoreConstants.addedPersons] ? this.store[IntakeStoreConstants.addedPersons] : [];
    // Need to validate if persons changed related with appointment
    this.addedPersons.forEach((person, index) => {
        if (!person.Pid) {
            person.Pid = AppConstants.PERSON.TEMP_ID + index;
        }
    });
  }

  getIntakeWorkerName(intakeWorkerID: string) {
    const intakeWorker = this.intakeWorkerList.find(iw => iw.userid === intakeWorkerID);
    if (intakeWorker) {
      return intakeWorker.username;
    }
    return null;
  }

  getPersonName(personId: string | undefined) {
    const person = this.addedPersons.find(p => p.Pid === personId);
    if (person) {
        return person.fullName;
    }
}

  private loadIntakeWorkers() {

    this._commonHttpService.getPagedArrayList(
      {

        method: 'get',
        nolimit: true,
        page: 1,
        limit: 50,
        order: 'username'
      },
      NewUrlConfig.EndPoint.Intake.intakeWorkerList + '?filter'
    ).pipe(map(response => {
      this.intakeWorkerList = response.data;
      return response.data;
    })).subscribe();


  }

}
