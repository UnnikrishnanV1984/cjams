
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Observable } from 'rxjs';
import { TransportService } from '../transport.service';
import { DataStoreService, AlertService, CommonHttpService } from '../../../../../@core/services';
import { TransportationAddEdit, Transportation } from '../../../_entities/caseworker.data.model';
import moment from 'moment';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    selector: 'transport-add-edit',
    templateUrl: './transport-add-edit.component.html',
    styleUrls: ['./transport-add-edit.component.scss'],
    standalone: false
})
export class TransportAddEditComponent implements OnInit {
  id: string;
  personid!: string;
  youthName!: string;
  dob!: string;
  isFromOther!: boolean;
  isToOther!: boolean;
  minDateOfTrasnport!: Date;
  operation: string | null;
  transportid: string | null;
  transport!: Transportation;

  fromDropdownItems$!: Observable<any[]>;
  toDropdownItems$!: Observable<any[]>;
  toDropdownAllItems$!: Observable<any[]>;
  toDropdownItems!: any[];
  OffenceValuesDropdownItems$!: Observable<DropdownModel[]>;
  transportForm!: FormGroup;

  DAYS = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  persontransportapproved = 'Person Transportaion Review Approved';
  constructor(private _dropDownService: CommonHttpService,private _transportationService: TransportService, private _router: Router, private route: ActivatedRoute, private _formBuilder: FormBuilder,
    private _dataStore: DataStoreService, private _alert: AlertService) {
    this.operation = this.route.snapshot.paramMap.get('operation');
    this.transportid = this.route.snapshot.paramMap.get('transportid');
    this.id = this._dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  ngOnInit() {
    this.isFromOther = false;
    this.isToOther = false;
    this._dataStore.currentStore.subscribe(store => {
      if (!(this.personid && this.dob && this.youthName)) {
        this.personid = store['da_personid'];
        this.youthName = store['da_focus'];
        this.dob = store['da_persondob'];
        this.initAddTransportForm();
      }
    });

    this.loadDropdowns();
    this.initAddTransportForm();
    const threeDaysAfter = new Date();
    threeDaysAfter.setDate(new Date().getDate() + 3);
    this.minDateOfTrasnport = threeDaysAfter;
    if (this.transportid) {
      this._transportationService.getTransportById(this.transportid).subscribe(res => {
        this.transport = res[0];
        this.transport.intakeserviceid = this.id;
        this.transport.otherlocationfrom = (this.transport.locationfromtypekey === 'Other') ? this.transport.pickuplocation : '';
        this.transport.otherlocationto = (this.transport.locationtotype === 'Other') ? this.transport.dropofflocation : '';
        this.transport.locationtotypekey = this.transport.locationtotype;
        this.transport.pickuptime = moment(this.transport.pickuptime).format('HH:mm');
        this.transport.droptime = moment(this.transport.droptime).format('HH:mm');
        this.transport.courttime = moment(this.transport.courttime).format('HH:mm');
        this.transportForm.patchValue(this.transport);
        this.fromChange(this.transport.locationfromtypekey);
        this.toChange(this.transport.locationtotypekey);
        this.dateOfTransportChange(this.transport.dateoftransport);
      });
    }
    this.getOffenceDropdown();
  }

  getOffenceDropdown() {
    this.OffenceValuesDropdownItems$ = this._dropDownService
        .getArrayList(
            {
                where: {
                  intakeserviceid: this.id
                },
                method: 'get',
            },
            'admin/allegation/getoffenselist?filter'
        ).pipe(
        map(result => {
            return result.map(
                res =>
                    new DropdownModel({
                        text: res.allegationname,
                        value: res.allegationid
                    })
            );
        }));
}

  initAddTransportForm() {
    this.transportForm = this._formBuilder.group({
      intakeserviceid: null,
      dateoftransport: [null, Validators.required],
      dateoftransportdrop: [null, Validators.required],
      pickuptime: '08:00',
      droptime: '08:00',
      youthname: { value: this.youthName, disabled: true },
      courttime: '08:00',
      dob: { value: this.dob, disabled: true },
      courtlocation: null,
      locationfromtypekey: [null, Validators.required],
      otherlocationto: null,
      chargereason: null,
      notes: null,
      locationtotypekey: [null, Validators.required],
      otherlocationfrom: null,
      allegationid: null,
      day: [{ value: null, disabled: true }, Validators.required]
    });
  }

  loadDropdowns() {
    this.fromDropdownItems$ = this._transportationService.getFromDropDownList();
    this.toDropdownItems$ = this._transportationService.getToDropDownList();
    this.toDropdownAllItems$ = this._transportationService.getToDropDownList();
  }

  openTransportationRequest() {
    this.initAddTransportForm();
    (<any>$('#myModal')).modal('show');
  }

  dateOfTransportChange(dateOfTransport: string | number | Date) {
    const day = this.DAYS[new Date(dateOfTransport).getDay()];
    this.transportForm.patchValue({ day: day });
  }

  fromChange(dropdownValue: string) {
    this.toDropdownItems$ = this.toDropdownAllItems$.pipe(map(res => {
      return res.filter((result) => result.locationtotypekey !==  dropdownValue || result.locationtotypekey === 'Other');
    }));
    if (dropdownValue === 'Other') {
      this.isFromOther = true;
      this.transportForm.get('otherlocationfrom')?.setValidators(Validators.required);
    } else {
      this.isFromOther = false;
      this.transportForm.get('otherlocationfrom')?.setValue(null);
      this.transportForm.get('otherlocationfrom')?.clearValidators();
    }
    this.transportForm.get('otherlocationfrom')?.updateValueAndValidity();
  }

  toChange(dropdownValue: string) {
    if (dropdownValue === 'Other') {
      this.isToOther = true;
      this.transportForm.get('otherlocationto')?.setValidators(Validators.required);
    } else {
      this.isToOther = false;
      this.transportForm.get('otherlocationto')?.setValue(null);
      this.transportForm.get('otherlocationto')?.clearValidators();
    }
    this.transportForm.get('otherlocationto')?.updateValueAndValidity();
  }

  saveTransport() {
    const transport: TransportationAddEdit = this.transportForm.getRawValue();
    transport.intakeserviceid = this.id;
    transport.personid = this.personid;
    transport.droptime = this.addTimeToDate(transport.dateoftransportdrop, transport.droptime);
    transport.pickuptime = this.addTimeToDate(transport.dateoftransport, transport.pickuptime);
    transport.courttime = this.addTimeToDate(transport.dateoftransport, transport.courttime);
    this._transportationService.addTrasnsport(transport).subscribe(res => {
      if (res.persontransportationid) {
        const routData = {
          'objectid': res.persontransportationid,
          'eventcode': 'PNTR',
          'status': 'TRAPP',
          'comments': this.persontransportapproved,
          'notifymsg':  this.persontransportapproved,
          'routeddescription':  this.persontransportapproved
        };
        this._transportationService.routingupdateTransport(routData).subscribe(() => {
          this._alert.success('Transportation details added and Routed successfully.');
          this.goBackToList();
        });
      } else {
        this._alert.error('Add Transportation failed, please try again.');
      }
    });
  }

  updateTransport() {
    const transport: TransportationAddEdit = this.transportForm.getRawValue();
    transport.intakeserviceid = this.id;
    transport.personid = this.personid;
    transport.droptime = this.addTimeToDate(transport.dateoftransportdrop, transport.droptime);
    transport.pickuptime = this.addTimeToDate(transport.dateoftransport, transport.pickuptime);
    transport.courttime = this.addTimeToDate(transport.dateoftransport, transport.courttime);
    this._transportationService.updateTransport(transport, this.transportid).subscribe(res => {
      if (res.count) {
        this._alert.success('Transportation details updated successfully.');
        this.goBackToList();
      } else {
        this._alert.error('Update Transportation failed, please try again.');
      }
    });
  }
  addTimeToDate(dateString: string | number | Date, time: string) {
    if (!time) {
      return null;
    }
    const date: any = new Date(dateString);
    const timeSplit = time.split(':');
    date.setHours(timeSplit[0]);
    date.setMinutes(timeSplit[1]);
    return date;
  }

  goBackToList() {
    if (this.operation === 'add') {
      this._router.navigate(['../'], { relativeTo: this.route });
    } else {
      this._router.navigate(['../../'], { relativeTo: this.route });
    }
  }
}
