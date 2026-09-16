import { Component, OnInit } from '@angular/core';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, CommonHttpService, AlertService, AuthService } from '../../../../@core/services';
import { FinanceUrlConfig } from '../../finance.url.config';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import moment from 'moment';

@Component({
    selector: 'ssi-ssa-overview',
    templateUrl: './ssi-ssa-overview.component.html',
    styleUrls: ['./ssi-ssa-overview.component.scss'],
    standalone: false
})
export class SsiSsaOverviewComponent implements OnInit {
  showSsnMask:boolean=true;
  clientid: any;
  typeSsi = false;
  typeSsa = false;
  ssiSsaEligibilityEvents!: any[];
  paginationInfo: PaginationInfo = new PaginationInfo();
  eligibilityEventForm!: FormGroup;
  eventStatus!: any[];
  ssiSsaEventType!: any[];
  ssiSsaEligibilityType!: any[];
  loggedInUser!: string;
  ssiSsaStatus = 'addEvent';
  eligibility_id: any;
  event_id: any;
  eventsList!: any[];
  eligibility_index!: number;
  enableEligibilityEvent = true;
  ssiSsaSingleData: any;
  disabled: any;
  eligibilityMinDate!: Date;
  eventMinDate!: Date;
  eligibilityMaxDate!: Date;
  pageInfo: PaginationInfo = new PaginationInfo();
  ssiSsaPayment!: any[];
  dtformat = 'YYYY-MM-DD';
  isAuthorized :any; //for fortify issues 
  addeventpopupid = '#add-event';
  constructor(
    private fb: FormBuilder,
    private _route: ActivatedRoute,
    private _router: Router,
    private _datastoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService,
    private _authService: AuthService) {
      this.clientid = this._route.snapshot.params['clientid'];
    }

  ngOnInit() {
    this.isAuthorized= this._datastoreService.isAuthorized();
    this.loggedInUser = this._authService.getCurrentUser().user.username;
    this.getSsiSsaOverview();
    this.initEligibilityEventForm();
    this.loadDropdown();
    this.pageInfo.pageNumber = 1;
  
  }

  loadDropdown() {
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '208'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe(res => {
      this.eventStatus = res;
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '206'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe(res => {
      this.ssiSsaEventType = res;
    });
    this._commonHttpService.getArrayList({
      where: {
        picklist_type_id: '207'
      },
      nolimit: 'true',
      method: 'get'
    }, FinanceUrlConfig.EndPoint.general.dropdownURL).subscribe(res => {
      this.ssiSsaEligibilityType = res;
    });
  }

  initEligibilityEventForm() {
    this.eligibilityEventForm = this.fb.group({
      eligibility_status_cd: [null],
      eligibility_type_cd: [null],
      start_dt: [null],
      end_dt: [null],
      entry_dt: [null],
      event_type_cd: [null],
      event_start_dt: [null],
      event_end_dt: [null],
      notes_tx: [null],
      entered_by: [null],
      status_cd: [null],
      status_change_sw: [null]
    });

  }

  getSsiSsaOverview() {
    this._commonHttpService.getPagedArrayList({
      limit: this.paginationInfo.pageSize,
      page: this.paginationInfo.pageNumber,
      where: {
            client_id: (this.clientid) ?  this.clientid : null,
          },
      method: 'get'
    }, FinanceUrlConfig.EndPoint.ssiSsaTracking.eligibilityEvents + '?filter').subscribe((res: any) => {
        if (res) {
            this.ssiSsaEligibilityEvents = res.data;
            this.ssiSsaSingleData = (this.ssiSsaEligibilityEvents) ? this.ssiSsaEligibilityEvents[0]: '';
            const isEligibleSsi = this.ssiSsaEligibilityEvents.find(data => data.eligibility_type === 'SSI');
            this.typeSsi = (isEligibleSsi) ? isEligibleSsi : false;

            const isEligibleSsa = this.ssiSsaEligibilityEvents.find(data => data.eligibility_type === 'SSA');
            this.typeSsa = (isEligibleSsa) ? isEligibleSsa : false;

            this.eligibilityEventPatchForm();
        }
    });
  }

  eligibilityEventPatchForm() {
    if (this.ssiSsaEligibilityEvents.length > 0) {
      const eventData = this.ssiSsaEligibilityEvents[0];
      this.eligibilityEventForm.patchValue({
        eligibility_type_cd: eventData.eligibility_type_cd,
        entry_dt: moment(new Date()).format(this.dtformat),
        entered_by: this.loggedInUser
      });
    }
  }

  addEligibility() {
    this.eligibilityEventForm.reset();
    this.enableEligibilityEvent = true;
    this.ssiSsaStatus = 'addEligibility';
    this.resetForm();
    this.eligibilityEventForm.patchValue({
      entry_dt: moment(new Date()).format(this.dtformat),
      entered_by: this.loggedInUser
    });

    this.eligibilityEventForm.enable();
    this.eligibilityEventForm.get('entry_dt')?.disable();
    this.eligibilityEventForm.get('entered_by')?.disable();
  }

  addEvent(eligibilityEvent: any, index: number) {
    this.enableEligibilityEvent = true;
    this.ssiSsaStatus = 'addEvent';
    this.resetForm();
    this.disableEligibilityFields();
    this.enableEventFields();
    this.eligibilityEventForm.patchValue({
      entry_dt: moment(new Date()).format(this.dtformat),
      entered_by: this.loggedInUser
    });
    this.eligibility_id = eligibilityEvent.eligibility_id;
    this.event_id = null;
    this.eligibilityEventForm.patchValue({
      eligibility_type_cd: eligibilityEvent.eligibility_type_cd,
      eligibility_status_cd: eligibilityEvent.eligibility_status_cd,
      start_dt: eligibilityEvent.start_dt,
      end_dt: eligibilityEvent.end_dt
    });
    (<any>$(this.addeventpopupid)).modal('show');
  }

  resetForm() {
    this.eligibilityEventForm.reset();
  }

  saveEligibilityEvents() {
    const model = this.modelDataFn();

    if ( this.eligibilityEventForm.getRawValue().start_dt !== '' && this.eligibilityEventForm.getRawValue().end_dt !== '') {
      const eligibilityStartDate = moment(new Date(this.eligibilityEventForm.getRawValue().start_dt)).format(this.dtformat);
      const eligibilityEndDate = moment(new Date(this.eligibilityEventForm.getRawValue().end_dt)).format(this.dtformat);
      if ( new Date(eligibilityStartDate).getTime() > new Date(eligibilityEndDate).getTime()) {
        this._alertService.error('Eligibility end date should be greater than or equal to start date');
        return false;
      }
    }

    if ( this.eligibilityEventForm.getRawValue().event_start_dt !== '' && this.eligibilityEventForm.getRawValue().event_end_dt !== '') {
      const eventStartDate = moment(new Date(this.eligibilityEventForm.getRawValue().event_start_dt)).format(this.dtformat);
      const eventEndDate = moment(new Date(this.eligibilityEventForm.getRawValue().event_end_dt)).format(this.dtformat);

      if ( new Date(eventStartDate).getTime() > new Date(eventEndDate).getTime()) {
        this._alertService.error('Event end date should be greater than or equal to start date');
        return false;
      }
    }

    this.checkSsiSsaStatusFn(model);

    if (this.eligibilityEventForm.getRawValue().end_dt) {
        if (!this.eligibilityEventForm.getRawValue().event_end_dt) {
          this._alertService.error('Please select event end date');
          this.eligibilityEventForm.controls['event_end_dt'].setValidators([Validators.required]);
          this.eligibilityEventForm.controls['event_end_dt'].updateValueAndValidity();
          return;
        } else {
          this.eligibilityEventForm.controls['event_end_dt'].clearValidators();
          this.eligibilityEventForm.controls['event_end_dt'].updateValueAndValidity();
        }
    }
    this._commonHttpService.create(model, FinanceUrlConfig.EndPoint.ssiSsaTracking.addEligibilityEvents).subscribe(
      (result) => {
        if (result) {
          (<any>$(this.addeventpopupid)).modal('hide');
          this._alertService.success('Information added successfully');
          this.getSsiSsaOverview();
        }
    });
  }

  private checkSsiSsaStatusFn(model: any) {
    if (this.ssiSsaStatus === 'editEligibility') {
      model.eligibility_id = this.returnEligibilityIdFn();
      model.event_id = this.returnEventIdFn();
      model.is_event_only = false;
    } else if (this.ssiSsaStatus === 'editEvent') {
      model.eligibility_id = this.returnEligibilityIdFn();
      model.event_id = this.returnEventIdFn();
      model.is_event_only = true;
    } else if (this.ssiSsaStatus === 'addEvent') {
      model.eligibility_id = this.returnEligibilityIdFn();
      model.event_id = null;
      model.is_event_only = true;
    } else {
      model.eligibility_id = null;
      model.event_id = null;
      model.is_event_only = false;
    }
  }

  private returnEventIdFn(): any {
    return (this.event_id) ? this.event_id : null;
  }

  private returnEligibilityIdFn(): any {
    return (this.eligibility_id) ? this.eligibility_id : null;
  }

  private modelDataFn() {
    return {
      start_dt: (this.eligibilityEventForm.getRawValue().start_dt) ? moment(this.eligibilityEventForm.getRawValue().start_dt).format(this.dtformat) : null,
      end_dt: (this.eligibilityEventForm.getRawValue().end_dt) ? moment(this.eligibilityEventForm.getRawValue().end_dt).format(this.dtformat) : null,
      event_start_dt: (this.eligibilityEventForm.getRawValue().event_start_dt) ? moment(this.eligibilityEventForm.getRawValue().event_start_dt).format(this.dtformat) : null,
      event_end_dt: (this.eligibilityEventForm.getRawValue().event_end_dt) ? moment(this.eligibilityEventForm.getRawValue().event_end_dt).format(this.dtformat) : null,
      eligibility_status_cd: this.eligibilityEventForm.getRawValue().status_cd,
      eligibility_type_cd: this.eligibilityEventForm.getRawValue().eligibility_type_cd,
      client_id: this.clientid,
      event_type_cd: this.eligibilityEventForm.getRawValue().event_type_cd,
      status_cd: this.eligibilityEventForm.getRawValue().status_cd,
      notes_tx: this.eligibilityEventForm.getRawValue().notes_tx,
      status_change_sw: (this.eligibilityEventForm.getRawValue().status_change_sw) ? 'Y' : 'N',
      eligibility_id: null,
      event_id: null,
      is_event_only: false
    };
  }

  editEligibility(eligibilityEvent: any) {
    this.resetForm();
    this.enableEligibilityEvent = true;
    this.eligibility_id = eligibilityEvent.eligibility_id;
    this.ssiSsaStatus = 'editEligibility';

    this.eligibilityEventForm.patchValue({
      eligibility_type_cd: eligibilityEvent.eligibility_type_cd,
      eligibility_status_cd: eligibilityEvent.eligibility_status_cd,
      start_dt: eligibilityEvent.start_dt,
      end_dt: eligibilityEvent.end_dt
    });

    if (eligibilityEvent.events.length > 0) {
      let activeEvent = eligibilityEvent.events.filter((data: any) => data.delete_sw === 'N');

      if (activeEvent.length > 0) {
        activeEvent = activeEvent[0];
        this.event_id = activeEvent.event_id;
        this.eligibilityEventForm.patchValue({
          // eligibility_type_cd: eligibilityEvent.eligibility_type_cd,
          // eligibility_status_cd: eligibilityEvent.eligibility_status_cd,
          // start_dt: eligibilityEvent.start_dt,
          // end_dt: eligibilityEvent.end_dt,
          entry_dt: activeEvent.entry_dt,
          entered_by: activeEvent.entered_by,
          event_type_cd: activeEvent.event_type_cd,
          status_cd: activeEvent.status_cd,
          notes_tx: activeEvent.notes_tx,
          event_start_dt: activeEvent.start_dt,
          event_end_dt: activeEvent.end_dt,
          status_change_sw: (activeEvent.status_change_sw === 'N') ? false : true
        });
      }
    }

    setTimeout( () => {
      this.eligibilityMinDate = new Date(eligibilityEvent.start_dt);
      this.eventMinDate = new Date(eligibilityEvent.start_dt);
      this.eligibilityMaxDate = new Date(eligibilityEvent.end_dt);
    }, 200);

    this.eligibilityEventForm.get('eligibility_type_cd')?.disable();
    this.eligibilityEventForm.get('start_dt')?.disable();
    this.eligibilityEventForm.get('entry_dt')?.disable();
    this.eligibilityEventForm.get('entered_by')?.disable();
    this.eligibilityEventForm.get('event_type_cd')?.disable();
    this.eligibilityEventForm.get('status_cd')?.disable();
    this.eligibilityEventForm.get('event_start_dt')?.disable();
    this.eligibilityEventForm.get('notes_tx')?.disable();
    this.eligibilityEventForm.get('status_change_sw')?.disable();

    this.eligibilityEventForm.get('end_dt')?.enable();
    this.eligibilityEventForm.get('event_end_dt')?.enable();

    (<any>$(this.addeventpopupid)).modal('show');
  }

  showEvents(id: string, index: number) {
    (<any>$('.collapse.in')).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
    if (this.ssiSsaEligibilityEvents[index]) {
      this.eventsList = this.ssiSsaEligibilityEvents[index].events;
    }
  }

  editEvent(event: any, editEligibilityIndex: number) {
    this.resetForm();
    this.enableEligibilityEvent = true;
    this.ssiSsaStatus = 'editEvent';
    this.event_id = event.event_id;
    this.eligibility_id = (this.ssiSsaEligibilityEvents[editEligibilityIndex]) ?
                          this.ssiSsaEligibilityEvents[editEligibilityIndex].eligibility_id : null;
    this.enableEventFields();
    this.patchEventData(event, editEligibilityIndex);
    setTimeout( () => {
      this.eligibilityMinDate = new Date(this.eligibilityEventForm.getRawValue().start_dt);
      this.eventMinDate = new Date(this.eligibilityEventForm.getRawValue().start_dt);
      this.eligibilityMaxDate = new Date(this.eligibilityEventForm.getRawValue().end_dt);
    }, 200);

    (<any>$(this.addeventpopupid)).modal('show');
  }

  viewEligibilityEvent(event: any, editEligibilityIndex: number) {
    this.resetForm();
    this.enableEligibilityEvent = false;
    this.patchEventData(event, editEligibilityIndex);
    this.eligibilityEventForm.get('event_type_cd')?.disable();
    this.eligibilityEventForm.get('status_cd')?.disable();
    this.eligibilityEventForm.get('event_start_dt')?.disable();
    this.eligibilityEventForm.get('event_end_dt')?.disable();
    this.eligibilityEventForm.get('notes_tx')?.disable();
    this.eligibilityEventForm.get('status_change_sw')?.disable();
    (<any>$(this.addeventpopupid)).modal('show');
  }

  patchEventData(event: any, editEligibilityIndex: number) {
    if (this.ssiSsaEligibilityEvents[editEligibilityIndex]) {
      const ssiSsaEligibilityData = this.ssiSsaEligibilityEvents[editEligibilityIndex];
      this.eligibilityEventForm.patchValue({
        eligibility_type_cd: ssiSsaEligibilityData.eligibility_type_cd,
        eligibility_status_cd: ssiSsaEligibilityData.eligibility_status_cd,
        start_dt: ssiSsaEligibilityData.start_dt,
        end_dt: ssiSsaEligibilityData.end_dt,
      });
    }
    this.eligibilityEventForm.patchValue({
      entry_dt: event.entry_dt,
      entered_by: event.entered_by,
      event_type_cd: event.event_type_cd,
      status_cd: event.status_cd,
      notes_tx: event.notes_tx,
      event_start_dt: event.start_dt,
      event_end_dt: event.end_dt,
      status_change_sw: (event.status_change_sw === 'N') ? false : true
    });
    this.disableEligibilityFields();
  }

  disableEligibilityFields() {
    this.eligibilityEventForm.get('eligibility_type_cd')?.disable();
    this.eligibilityEventForm.get('start_dt')?.disable();
    this.eligibilityEventForm.get('end_dt')?.disable();
    this.eligibilityEventForm.get('entry_dt')?.disable();
    this.eligibilityEventForm.get('entered_by')?.disable();
  }

  enableEventFields() {
    this.eligibilityEventForm.get('event_type_cd')?.enable();
    this.eligibilityEventForm.get('status_cd')?.enable();
    this.eligibilityEventForm.get('event_start_dt')?.enable();
    this.eligibilityEventForm.get('event_end_dt')?.enable();
    this.eligibilityEventForm.get('notes_tx')?.enable();
    this.eligibilityEventForm.get('status_change_sw')?.enable();
  }

  isActiveEvents(events: any[]) {
    if (events.length > 0) {
      return events.find(event => event.delete_sw === 'Y');
    }
     return true;
  }

  onChangeDate(form: any, field: string) {
    if ( field === 'start_dt' ) {
       this.eligibilityMinDate = new Date(form.getRawValue().start_dt);
       this.eventMinDate = new Date(form.getRawValue().start_dt);
       this.eligibilityMaxDate = new Date(form.value.end_dt);
        form.get('end_dt').reset();
        if (form.get('event_start_dt').enabled) {
          form.get('event_start_dt').reset();
        }
        form.get('event_end_dt').reset();
    } else  if ( field === 'end_dt' ) {
      this.eligibilityMinDate = new Date(form.getRawValue().start_dt);
      this.eventMinDate = new Date(form.getRawValue().start_dt);
      this.eligibilityMaxDate = new Date(form.value.end_dt);
      if (form.get('event_start_dt').enabled) {
        form.get('event_start_dt').reset();
      }
      form.get('event_end_dt').reset();
    } else if ( field === 'event_start_dt') {
       this.eventMinDate = new Date(form.getRawValue().event_start_dt);
       form.get('event_end_dt').reset();
    }
  }

  getPayment() {
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
          limit: this.pageInfo.pageSize,
          page: this.pageInfo.pageNumber,
          method: 'get',
          where:  {
            client_id: (this.clientid) ?  this.clientid : null
          }
      }),
      FinanceUrlConfig.EndPoint.ssiSsaTracking.paymentList + '?filter'
  ).subscribe(response => {
    if (response) {
      this.ssiSsaPayment = response.data;
    }
  });
  }
   pageNumberChanged(page: number) {
    this.pageInfo.pageNumber = page;
    this.getPayment();
   }
}
