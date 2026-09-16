
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { BehaviouralHealthInfo } from '../../../../../@core/common/models/involvedperson.data.model';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AlertService, CommonHttpService, AuthService, CommonDropdownsService } from '../../../../../@core/services';
import { NgxfUploaderService, FileError } from 'ngxf-uploader';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { AppConfig } from '../../../../../app.config';
import { HttpHeaders } from '@angular/common/http';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { BehavioralHealthInfoService } from '../behavioral-health-info.service';
import { ActivatedRoute } from '@angular/router';
import { PersonDetailsService } from '../../../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'behavioral-health-info-create-edit',
    templateUrl: './behavioral-health-info-create-edit.component.html',
    styleUrls: ['./behavioral-health-info-create-edit.component.scss'],
    standalone: false
})
export class BehavioralHealthInfoCreateEditComponent implements OnInit {

  behaviouralhealthinfoForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  ethinicityDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<any[]>;
  private token: AppUser;
  uploadedFile!: File;
  resourceId!: string | null;

    private formbulider: FormBuilder;
    private _alertSevice: AlertService;
    private _commonHttpService: CommonHttpService;
    private personService: PersonDetailsService;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private route: ActivatedRoute;
    private _commonDropdownsService: CommonDropdownsService;
    private _behaviorHealthService: BehavioralHealthInfoService

  constructor(private injector : Injector){
    this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice =  this.injector.get<AlertService>(AlertService);
    this._commonHttpService =  this.injector.get<CommonHttpService>(CommonHttpService);
    this.personService =  this.injector.get<PersonDetailsService>(PersonDetailsService);
    this._uploadService =  this.injector.get<NgxfUploaderService>(NgxfUploaderService);
    this._authService =  this.injector.get<AuthService>(AuthService);
    this.route =  this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._commonDropdownsService =  this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._behaviorHealthService =  this.injector.get<BehavioralHealthInfoService>(BehavioralHealthInfoService);
    
    this.token = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.loadDropDowns();
    this.editMode = false;
    this.reportMode = 'add';
    this.resourceId = null;
    this.modalInt = -1;
    this.behaviouralhealthinfoForm = this.formbulider.group({
      clinicianname: [null, Validators.required],
      address1: [null, Validators.required],
      address2: null,
      city: null,
      state: null,
      county: null,
      zip: null,
      phone: null,
      currentdiagnoses: null,
      reportname: [null],
      reportpath: null
    });

    this.route.params.subscribe(params => {
      this._behaviorHealthService.behaviorHealth$.subscribe(data => {
        data.forEach(element => {
          if (element.personbehavioralhealthid === params.id) {
            setTimeout(() => {
              this.patchForm(element);
              this.behaviouralhealthinfoForm.patchValue({
                county: element.countyid
              });
            }, 1000);
            this.loadCounty(element.state);
            if (params.reportMode === 'edit') {
              this.reportMode = 'edit';
              this.editMode = true;
              this.resourceId = params.id;
            } else if (params.reportMode === 'view') {
              this.behaviouralhealthinfoForm.disable();
              this.reportMode = 'view';
              this.editMode = false;
              this.resourceId = params.id;
            }
          }
        });
      });
    });
  }


  uploadFile(file: any): void {
    if (!(file instanceof File)) {
      return;
    }

    this.uploadedFile = file;
    this.behaviouralhealthinfoForm.patchValue({ reportname: file.name });
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: 1 },
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.EthnicGroupTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.StateListUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          ethinicities: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.ethnicgrouptypekey
              })
          ),
          states: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          )
        };
      }),
      share(),);
    this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
  }

  loadCounty(countystate?: any) {
    const state = countystate ? countystate : this.behaviouralhealthinfoForm.get('state')?.value;
    this.countyDropDownItems$ = this._commonDropdownsService.getCountyList(state);
  }


  addUpdate(behaviorHealthForm: any) {
    behaviorHealthForm.personbehavioralhealthid = this.resourceId;
    behaviorHealthForm.personid = this.personService.person.personid;
    this._behaviorHealthService.addUpdatebehaviorHealthInfo(behaviorHealthForm).subscribe((_result: any) => {
      this.resetForm();
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.success('Behavior Health Information details saved successfully!');
    }, error => {
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  oldadd() {
    this._uploadService
      .upload({
        url: AppConfig.baseUrl + '/' + CommonUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl,
        headers: new HttpHeaders().set('ctype', 'file'),
        filesKey: ['file'],
        files: this.uploadedFile,
        process: true
      })
      .subscribe(
        (response) => {
          if (response.status === 1 && response.data) {
            this._alertSevice.success('Added Successfully');
            this.resetForm();
            this._alertSevice.success('File Uploaded Succesfully!');
          }
        },
        (err) => {
          this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

  resetForm() {
    this.behaviouralhealthinfoForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.behaviouralhealthinfoForm.enable();
  }

  private patchForm(modal: BehaviouralHealthInfo) {
    this.behaviouralhealthinfoForm.patchValue(modal);
  }

}
