import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonDropdownsService, AlertService, AuthService } from '../../../../@core/services';
import { Observable } from 'rxjs';
import { FormGroup, FormBuilder } from '@angular/forms';
import { PersonAlertsService } from '../person-alerts.service';
import { Alert } from '../../../../@core/common/models/involvedperson.data.model';
import { AppConstants } from '../../../../@core/common/constants';
import moment from 'moment';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-alert-details',
    templateUrl: './person-alert-details.component.html',
    styleUrls: ['./person-alert-details.component.scss'],
    standalone: false
})
export class PersonAlertDetailsComponent implements OnInit {
  alertForm!: FormGroup;

  operation: string | null | undefined;
  alertTypes$!: Observable<any[]>;
  notes = 'Notes';
  alert: Alert = new Alert();
  editAlert: Alert | undefined | null = new Alert();
  personid: string | null | undefined;
  maxDate = new Date();
  isRestiutionAlertType = false;
  restiutionInfo: any;
  isEditable = false;
  isRC = false;
  actionText = 'Add Alert';
  constructor(private route: ActivatedRoute,
    private dropdownService: CommonDropdownsService,
    private _formBuilder: FormBuilder,
    private _alertsService: PersonAlertsService,
    private _alert: AlertService,
    private _authService: AuthService,
    private router: Router) {
    this.operation = this.route.snapshot.paramMap.get('operation');
    this.personid = this.route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
  }

  ngOnInit() {
    this.isRC = this._authService.selectedRoleIs(AppConstants.ROLES.RESTITUTION_COORDINATOR);
    this.initFormGroup();
    this.loadDropdowns();
    this.editAlert = this._alertsService.selectedAlert;
    if (this.editAlert) {
      this.alertForm.patchValue(this.editAlert);
    }
    if (this.editAlert && this.editAlert.alerttype === AppConstants.PERSON_ALERT_TYPE.RESTITUION) {
      this.displayRestiutionInfo();
    } else {
      this.resetRestiutionAlertType();
    }

    this.processFormActions();
  }

  initFormGroup() {
    this.alertForm = this._formBuilder.group({
      personalertid: null,
      alerttype: '',
      startdatetime: null,
      enddatetime: null,
      status: 'Active',
      notes: '',
      alertid: null
    });



  }

  loadDropdowns() {
    this.alertTypes$ = this.dropdownService.getAlertType();
  }

  addOrUpdateAlert() {
    this.alert = this.alertForm.getRawValue();
    this.alert.personid = this.personid;
    if (this.operation === 'create') {
      delete this.alert['personalertid'];
    }
    if (moment(this.alert.enddatetime).isBefore(moment(moment(this.alert.startdatetime).format('MM-DD-YYYY')))) {
      this._alert.warn('End date should be not be before Start date.');
      return;
    }
    if (this.isEditable) {
      this.updateAlert();
    } else {
      this._alertsService.addAlert(this.alert).subscribe(res => {
        if (res.personid) {
          this._alert.success('Alerts saved successfully.');
          this.alertForm.reset();
          setTimeout(() => {
            this.backToList();
          }, 10);
        }
      });
    }
  }

  updateAlert() {
    this.alert = this.alertForm.getRawValue();
    this.alert.personid = this.personid;
    this._alertsService.updateAlert(this.alert).subscribe(res => {
      this._alert.success('Alert updated successfully.');
      this.alertForm.reset();
      setTimeout(() => {
        this.backToList();
      }, 10);
    });
  }

  backToList() {
    this.alertForm.reset();
    this._alertsService.selectedAlert = null;
    this.router.navigate(['../'], { relativeTo: this.route });
  }

  displayRestiutionInfo() {
    this.isRestiutionAlertType = true;
    this._alertsService.getRestiutionAlertDetails(this.editAlert?.personalertid).subscribe(restiuioninfo => {
      if (restiuioninfo && restiuioninfo.length) {
        this.restiutionInfo = restiuioninfo[0];
      } else {
        this.restiutionInfo = restiuioninfo;
      }
    });
  }

  resetRestiutionAlertType() {
    this.isRestiutionAlertType = false;
  }

  processFormActions() {
    if (this.operation === 'create' || this.operation === 'edit') {
      this.isEditable = true;
      if (this.operation === 'edit') {
        this.actionText = 'Update Alert';
      }
      if (!this.isRC && this.isRestiutionAlertType) {
        this.isEditable = false;
        this.alertForm.disable();
      }
    } else {
      if (this.isRC && this.isRestiutionAlertType) {
        this.isEditable = true;
        this.actionText = 'Update Alert';
        this.alertForm.disable();
        this.alertForm.controls['enddatetime'].enable();
      } else {
        this.isEditable = false;
        this.alertForm.disable();
      }

    }

  }
  openPersonDetail(personid: any) {
    this.router.navigate(['/pages/person-details/view/' + personid + '/basic']);
  }
}
