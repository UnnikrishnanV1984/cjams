
import { EMPTY,  Observable ,  forkJoin } from 'rxjs';
import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { AppUser } from '../../../@core/entities/authDataModel';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { NgxfUploaderService, FileError } from 'ngxf-uploader';
import { CommonHttpService, AlertService, AuthService, CommonDropdownsService } from '../../../@core/services';
import { Education, School, Vocation, Testing, Accomplishment } from '../../../@core/common/models/involvedperson.data.model';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { AppConfig } from '../../../app.config';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { PersonEducationDetailsService } from './person-education-details.service';
import { PersonDetailsService } from '../person-details.service';
const TEST_LEVEL_BASIC = 'Basic';
const TEST_LEVEL_ADVANCED = 'Advanced';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-education-details',
    templateUrl: './person-education-details.component.html',
    styleUrls: ['./person-education-details.component.scss'],
    standalone: false
})
export class PersonEducationDetailsComponent implements OnInit {
  addEducation!: Education;
  schoolForm!: FormGroup;
  vocationForm!: FormGroup;
  testingForm!: FormGroup;
  accomplishmentForm!: FormGroup;
  vocationButton!: boolean;
  school: School[] = [];
  vocation: Vocation[] = [];
  testing: Testing[] = [];
  accomplishment: Accomplishment[] = [];
  vocationEditInd = 'ADD';
  schoolEditInd = 'ADD';
  testingEditInd = 'ADD';
  accomplishEditInd = 'ADD';
  isSpecialEducation = false;
  schoolTypeDropdownItems$!: Observable<DropdownModel[]>;
  specialEducationDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  lastGradeDropdownItems$!: Observable<DropdownModel[]>;
  currentGradeDropdownItems$!: Observable<DropdownModel[]>;
  testingTypeDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems: any[] = [];
  testingDescription!: string;
  gradeDescription!: string;
  schoolDescription!: string;
  maxDate = new Date();
  uploadedFile!: File;
  private token: AppUser;
  private personId!: string;
  schoolSearchList$ = new Observable<any>();
  schoolList$ = new Observable<any>();
  accomplishmentList$ = new Observable<any>();
  vocationList$ = new Observable<any>();
  basicTestingList$ = new Observable<any>();
  advancedTestingList$ = new Observable<any>();
  baseUrl = '';
  schoolResourceID!: string | null;
  schoolreportMode!: string;
  schoolxpandStatus = false;
  accompResourceID!: string | null;
  accompreportMode!: string;
  accompxpandStatus = false;
  testingResourceID!: string | null;
  testingreportMode!: string;
  testingxpandStatus = false;
  vocationResourceID!: string | null;
  vocationreportMode!: string;
  vocationxpandStatus = false;
  schoolid!: string | null;
  isBasicMode = true;
  testLevels = [TEST_LEVEL_BASIC, TEST_LEVEL_ADVANCED];
  deleteschoolinfopopupid = '#delete-schoolInfo-popup';
  deleteaccomplishmentinfopopupid = '#delete-accomplishmentInfo-popup';
  deletetestinginfopopupid = '#delete-testingInfo-popup';
  deletevocationpopup = '#delete-vocation-popup';
  displayorder = 'displayorder ASC';

  private formbulider: FormBuilder;
  private _uploadService: NgxfUploaderService;
  private _commonHttpService: CommonHttpService;
  private _alertSevice: AlertService;
  private _authService: AuthService;
  private http: HttpClient;
  private _commonDropdownsService: CommonDropdownsService;
  private _educationService: PersonEducationDetailsService;
  public _personDetailService: PersonDetailsService;


  constructor(private injector:Injector){
    this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
    this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.http = this.injector.get<HttpClient>(HttpClient);
    this._commonDropdownsService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._educationService = this.injector.get<PersonEducationDetailsService>(PersonEducationDetailsService);
    this._personDetailService = this.injector.get<PersonDetailsService>(PersonDetailsService);


    this.baseUrl = AppConfig.baseUrl;
    this.token = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.personId = this._personDetailService.person.personid;
    this.schoolSearchList$ = EMPTY;
    this.schoolList$ = EMPTY;
    this.accomplishmentList$ = EMPTY;
    this.basicTestingList$ = EMPTY;
    this.advancedTestingList$ = EMPTY;
    this.vocationList$ = EMPTY;
    this.schoolreportMode = 'add';
    this.accompreportMode = 'add';
    this.testingreportMode = 'add';
    this.vocationreportMode = 'add';
    this.schoolForm = this.formbulider.group({
      personeducationid: [''],
      personid: [''],
      educationname: ['', Validators.required],
      educationtypekey: [null, Validators.required],
      countyid: ['', Validators.required],
      statecode: ['', Validators.required],
      startdate: [null, Validators.required],
      enddate: [null],
      address: [''],
      zip: [''],
      lastgradetypekey: [null, Validators.required],
      currentgradetypekey: [null, Validators.required],
      isspecialeducation: [false],
      specialeducation: [''],
      specialeducationtypekey: [null],
      absentdate: [null],
      isreceived: [false],
      isverified: [false],
      isexcuesed: [false],
      reciveVeriExc: [''],
      extracurricular: ['']
    });

    this.testingForm = this.formbulider.group({
      personeducationtestingid: [''],
      personid: [''],
      testingtypekey: [null],
      testinginfotype: [TEST_LEVEL_BASIC],
      readinglevel: [null],
      readingtestdate: [null],
      mathlevel: [null],
      mathtestdate: [null],
      nameoftester: [null],
      pretestdate: [null],
      pretestscore: [null],
      posttestdate: [null],
      posttestscore: [null],
      testingprovider: ['']
    });

    this.accomplishmentForm = this.formbulider.group({
      personaccomplishmentid: [''],
      personid: [''],
      highestgradetypekey: [null],
      accomplishmentdate: [null],
      isrecordreceiveds: ['', [Validators.required]],
      receiveddate: [null]
    });

    this.vocationForm = this.formbulider.group({
      personeducationvocationid: [''],
      personid: [''],
      isvocationaltests: [''],
      vocationinterest: [''],
      vocationaptitude: [''],
      certificatename: [''],
      certificatepath: [''],
      uploadFile: ['']
    });
    this.loadDropDown();
    this.getSchoolList();
    this.getAccomplishmentList();
    this.getBasicTestingList();
    this.getAdvancedTestingList();
    this.getVocationList();
    this.addEducation = {
      school: [],
      testing: [],
      accomplishment: [],
      vocation: [],
      personId: this.personId
    };
  }

  checkTestMode() {
    const testForm = this.testingForm.getRawValue();
    if (testForm.testinginfotype === TEST_LEVEL_BASIC) {
      this.isBasicMode = true;
    } else {
      this.isBasicMode = false;
    }

  }

  sourceSelected(school: any) {
    this.loadCounty(school.statekey, school.countyid);
    setTimeout(() => {
      this.schoolid = school.schoolid;
      this.schoolForm.patchValue({
        educationtypekey: school.schooltypekey,
        statecode: school.statekey,
        address: school.address,
        zip: school.zipcode
      });
    }, 1000);
  }

  public loadCounty(countystate: any, countyid: any) {
    this._commonDropdownsService.getCountyList(countystate).subscribe(result => {
      this.countyDropDownItems = result;
      this.schoolForm.patchValue({
        countyid: countyid
      });
    });
  }

  public loadCountybystate(countystate: any) {
    this._commonDropdownsService.getCountyList(countystate).subscribe(result => {
      this.countyDropDownItems = result;
    });
  }

  schoolTypeDescription(model: any) {
    this.schoolDescription = '';
    this.schoolDescription = model.text;
  }

  addSchool(model: any) {
    model.personeducationid = this.schoolResourceID;
    if (this.schoolDescription && this.schoolDescription !== '') {
      model.schoolTypeDescription = this.schoolDescription;
    }
    model.isspecialeducation = this.isSpecialEducation;
    model.personid = this.personId;
    model.schoolid = this.schoolid;
    this._educationService.addUpdateSchool(model).subscribe((_result: any) => {
      this.getSchoolList();
      this.schoolEditInd = 'ADD';
      this.schoolResourceID = null;
      this.schoolid = null;
      this.schoolForm.reset();
      this._alertSevice.success('School details saved successfully!');
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getSchoolList() {
    const source = this._educationService.getSchoolList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this.personId },
        page: 1,
        limit: 10,
      }), 10);

    this.schoolList$ = source.pipe(pluck('data'));
  }

  editSchool(model: any, index: any) {
    this.schoolForm.patchValue(model);
    setTimeout(() => {
      this.schoolForm.patchValue({
        specialeducation: [model.isspecialeducation],
        address: model.school.address,
        zip: model.school.zipcode
      });
    }, 1000);
    this.schoolResourceID = model.personeducationid;
    this.schoolid = model.schoolid;
    this.schoolEditInd = 'UPDATE';
    this.specialEducation(model.isspecialeducation);
    this.schoolTypeDescription({ text: model.schoolTypeDescription, value: model.currentgradetypekey });
    this.schoolForm.enable();
    this.schoolreportMode = 'edit';
    this.loadCounty(model.statecode, model.countyid);
    if (!this.schoolxpandStatus) {
      this.schoolxpandStatus = true;
      this.accompxpandStatus = false;
      this.vocationxpandStatus = false;
      this.testingxpandStatus = false;
    }
  }
  viewSchool(model: any) {
    this.schoolForm.patchValue(model);
    setTimeout(() => {  // NO SONAR
      this.schoolForm.patchValue({ // This function has less than 3 lines of duplicate code.
        specialeducation: [model.isspecialeducation],
        zip: model.school.zipcode,
        address: model.school.address
      });
    }, 1000);
    this.schoolResourceID = model.personeducationid;
    this.specialEducation(model.isspecialeducation);
    this.schoolreportMode = 'view';
    this.loadCounty(model.statecode, model.countyid);
    if (!this.schoolxpandStatus) {
      this.schoolxpandStatus = true;
      this.accompxpandStatus = false;
      this.vocationxpandStatus = false;
      this.testingxpandStatus = false;
    }
    this.schoolForm.disable();
  }
  showDeletePopSchool(resourceid: any) {
    this.schoolResourceID = resourceid;
    (<any>$(this.deleteschoolinfopopupid)).modal('show');
  }
  deleteSchool() {
    this._educationService.deleteSchool(this.schoolResourceID).subscribe((response: any) => {
        this.getSchoolList();
        this.schoolResourceID = null;
        this.schoolid = null;
        this.schoolEditInd = 'ADD';
        this.schoolForm.reset();
        this._alertSevice.success('School deleted successfully');
        (<any>$(this.deleteschoolinfopopupid)).modal('hide');
      }, (_error: any) => {
        this.schoolResourceID = null;
        this.schoolid = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deleteschoolinfopopupid)).modal('hide');
      }
    );
  }

  addUpdateAccomplishment(model: any) {
    model.personaccomplishmentid = this.accompResourceID;
    model.personid = this.personId;
    if (this.gradeDescription && this.gradeDescription !== '') {
      model.gradedescription = this.gradeDescription;
    }
    model.isrecordreceived = model.isrecordreceiveds;
    this._educationService.addAccomplishmentSchool(model).subscribe(result => {
      this.getAccomplishmentList();
      this.accomplishEditInd = 'ADD';
      this.accompResourceID = null;
      this.accomplishmentForm.reset();
      this._alertSevice.success('Accomplishments details saved successfully!');
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getAccomplishmentList() {
    const source = this._educationService.getAccomplishmentList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this.personId },
        page: 1,
        limit: 10,
      }), 10);

    this.accomplishmentList$ = source.pipe(pluck('data'));
  }

  editAccomplishment(model: any, index: any) {
    this.accomplishmentForm.patchValue(model);
    setTimeout(() => {
      this.accomplishmentForm.patchValue({
        isrecordreceiveds: [model.isrecordreceived]
      });
    }, 100);
    this.highetGradeDescription(model.highestgradetypekey);
    if (model.isrecordreceived) {
      this.setManditory(!model.isrecordreceived, 'receiveddate', 'isManditory');
    } else {
      this.setManditory(!model.isrecordreceived, 'receiveddate', 'notManditory');
    }
    this.accompResourceID = model.personaccomplishmentid;
    this.accomplishEditInd = 'UPDATE';
    this.accomplishmentForm.enable();
    this.accompreportMode = 'edit';
    if (!this.accompxpandStatus) {
      this.accompxpandStatus = true;
      this.schoolxpandStatus = false;
      this.vocationxpandStatus = false;
      this.testingxpandStatus = false;
    }
  }
  viewAccomplishment(model: any) {
    this.accomplishmentForm.patchValue(model);
    setTimeout(() => {  // NOSONAR
      this.accomplishmentForm.patchValue({
        isrecordreceiveds: [model.isrecordreceived]
      });
    }, 100);
    this.highetGradeDescription(model.highestgradetypekey);
    if (model.isrecordreceived) {
      this.setManditory(!model.isrecordreceived, 'receiveddate', 'isManditory');
    } else {
      this.setManditory(!model.isrecordreceived, 'receiveddate', 'notManditory');
    }
    this.accompResourceID = model.personaccomplishmentid;
    this.accompreportMode = 'view';
    if (!this.accompxpandStatus) {
      this.accompxpandStatus = true;
      this.schoolxpandStatus = false;
      this.vocationxpandStatus = false;
      this.testingxpandStatus = false;
    }
    this.accomplishmentForm.disable();
  }
  showDeletePopAccomplishments(resourceid: any) {
    this.accompResourceID = resourceid;
    (<any>$(this.deleteaccomplishmentinfopopupid)).modal('show');
  }
  deleteAccomplishment() {
    this._educationService.deleteAccomplishment(this.accompResourceID).subscribe((response: any) => {
        this.getAccomplishmentList();
        this.accompResourceID = null;
        this.accomplishEditInd = 'ADD';
        this.accomplishmentForm.reset();
        this._alertSevice.success('Accomplishment deleted successfully');
        (<any>$(this.deleteaccomplishmentinfopopupid)).modal('hide');
      }, (error: any) => {
        this.accompResourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deleteaccomplishmentinfopopupid)).modal('hide');
      }
    );
  }

  addUpdateTesting(model: any) {
    model.personeducationtestingid = this.testingResourceID;
    model.personid = this.personId;
    if (this.testingDescription && this.testingDescription !== '') {
      model.testdescription = this.testingDescription;
    }
    this._educationService.addTesting(model).subscribe(result => {
      if (model.testinginfotype === TEST_LEVEL_BASIC) {
        this.getBasicTestingList();
      } else {
        this.getAdvancedTestingList();
      }
      this.testingEditInd = 'ADD';
      this.testingResourceID = null;
      this.testingForm.reset();
      this._alertSevice.success('Testing Info details saved successfully!');
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getAdvancedTestingList() {
    this.advancedTestingList$ = this.getTestingList(TEST_LEVEL_ADVANCED);
  }

  getBasicTestingList() {
    this.basicTestingList$ = this.getTestingList(TEST_LEVEL_BASIC);
  }
  getTestingList(testLevel: any) {
    const source = this._educationService.getTestingList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this.personId, testinginfotype: testLevel },
        page: 1,
        limit: 10,
      }), 10);

    return source.pipe(pluck('data'));
  }

  editTesting(model: any, index: any) {
    setTimeout(() => {
      this.testingForm.patchValue(model);
      this.checkTestMode();
    }, 100);
    this.selectTestingDescription({ text: model.testdescription, value: model.testingtypekey });
    this.testingResourceID = model.personeducationtestingid;
    this.testingEditInd = 'UPDATE';
    this.testingForm.enable();
    this.testingreportMode = 'edit';
    if (!this.testingxpandStatus) {
      this.testingxpandStatus = true;
      this.schoolxpandStatus = false;
      this.vocationxpandStatus = false;
      this.accompxpandStatus = false;
    }
  }
  viewTesting(model: any) {
    setTimeout(() => {
      this.testingForm.patchValue(model);
    }, 100);
    this.selectTestingDescription({ text: model.testdescription, value: model.testingtypekey });
    this.testingResourceID = model.personeducationtestingid;
    this.testingreportMode = 'view';
    if (!this.testingxpandStatus) {
      this.testingxpandStatus = true;
      this.schoolxpandStatus = false;
      this.vocationxpandStatus = false;
      this.accompxpandStatus = false;
    }
    this.testingForm.disable();
  }
  showDeletePopTesting(resourceid: any) {
    this.testingResourceID = resourceid;
    (<any>$(this.deletetestinginfopopupid)).modal('show');
  }
  deleteTesting() {
    this._educationService.deleteTesting(this.testingResourceID).subscribe((response) => {
        this.getAdvancedTestingList();
        this.getBasicTestingList();
        this.testingResourceID = null;
        this.testingEditInd = 'ADD';
        this.testingForm.reset();
        this._alertSevice.success('Testing Info deleted successfully');
        (<any>$(this.deletetestinginfopopupid)).modal('hide');
      }, (error: any) => {
        this.testingResourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletetestinginfopopupid)).modal('hide');
      }
    );
  }

  addUpdateVocation(model: any) {
    model.personeducationvocationid = this.vocationResourceID;
    model.personid = this.personId;
    model.isvocationaltest = model.isvocationaltests;
     
    this._educationService.addVocation(model).subscribe(result => {
      this.getVocationList();
      this.vocationEditInd = 'ADD';
      this.vocationResourceID = null;
      this.vocationForm.reset();
      this._alertSevice.success('Vocation details saved successfully!');
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getVocationList() {
    const source = this._educationService.getVocationList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this.personId },
        page: 1,
        limit: 10,
      }), 10);

    this.vocationList$ = source.pipe(pluck('data'));
  }

  editVocation(model: any, index: any) {
    setTimeout(() => {
      this.vocationForm.patchValue(model);
      this.vocationForm.patchValue({
        isvocationaltests: [model.isvocationaltest]
      });
    }, 100);
    this.vocationResourceID = model.personeducationvocationid;
    this.vocationEditInd = 'UPDATE';
    this.vocationForm.enable();
    this.vocationreportMode = 'edit';
    if (!this.vocationxpandStatus) {
      this.vocationxpandStatus = true;
      this.schoolxpandStatus = false;
      this.testingxpandStatus = false;
      this.accompxpandStatus = false;
    }
  }
  viewVocation(model: any) {
    setTimeout(() => {    // NOSONAR
      this.vocationForm.patchValue(model);
      this.vocationForm.patchValue({
        isvocationaltests: [model.isvocationaltest]
      });
    }, 100);
    this.vocationResourceID = model.personeducationvocationid;
    this.vocationreportMode = 'view';
    if (!this.vocationxpandStatus) {
      this.vocationxpandStatus = true;
      this.schoolxpandStatus = false;
      this.testingxpandStatus = false;
      this.accompxpandStatus = false;
    }
    this.vocationForm.disable();
  }
  showDeletePopVocation(resourceid: any) {
    this.vocationResourceID = resourceid;
    (<any>$(this.deletevocationpopup)).modal('show');
  }
  deleteVocation() {
    this._educationService.deleteVocation(this.vocationResourceID).subscribe(
      response => {
        this.getVocationList();
        this.vocationResourceID = null;
        this.vocationEditInd = 'ADD';
        this.vocationForm.reset();
        this._alertSevice.success('Vocation Info deleted successfully');
        (<any>$(this.deletevocationpopup)).modal('hide');
      },
      error => {
        this.vocationResourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletevocationpopup)).modal('hide');
      }
    );
  }

  selectTestingDescription(model: any) {
    this.testingDescription = '';
    this.testingDescription = model.text;
  }
  highetGradeDescription(model: any) {
    this.gradeDescription = '';
    this.gradeDescription = model.text;
  }
  setManditory(state: boolean, inputfield: string, manditory: string) {
    if (state === false && manditory === 'isManditory') {
      if (inputfield === 'receiveddate') {
        this.accomplishmentForm.get('isrecordreceiveds')?.valueChanges.subscribe((recordRecived: any) => {
          if (recordRecived === 'Yes') {
            this.accomplishmentForm.get('receiveddate')?.setValidators([Validators.required]);
            this.accomplishmentForm.get('receiveddate')?.updateValueAndValidity();
          } else {
            this.accomplishmentForm.get('receiveddate')?.clearValidators();
            this.accomplishmentForm.get('receiveddate')?.updateValueAndValidity();
          }
        });
      }
    }
  }
  addVocation(model: Vocation) {
    // upload attachment
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
            this.vocation.push(model);
            this.vocation[this.vocation.length - 1].certificatename = response.data.originalfilename;
            this.vocation[this.vocation.length - 1].certificatepath = response.data.s3bucketpathname;
            this.vocationForm.reset();
            this.addEducation.vocation = this.vocation;
            this._alertSevice.success('File Uploaded Succesfully!');
          }
        },
        (err) => {
          console.error(err);
          this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        } 
      );
    // end of attachment upload
  }

  uploadFile(file: any): void {
    if (!(file instanceof File)) {
      return;
    }
    this.uploadedFile = file;
    this.vocationForm.patchValue({ certificatename: file.name });
  }
  private loadDropDown() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { isspecialeducation: false },
          order: this.displayorder
        },
        CommonUrlConfig.EndPoint.Intake.EducationTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { isspecialeducation: true },
          order: this.displayorder
        },
        CommonUrlConfig.EndPoint.Intake.EducationTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.StateListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { ishighergrade: false },
          order: this.displayorder
        },
        CommonUrlConfig.EndPoint.Intake.GradeTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { ishighergrade: true },
          order: this.displayorder
        },
        CommonUrlConfig.EndPoint.Intake.GradeTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.TestingTypeUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          schoolType: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.educationtypekey
              })
          ),
          specialEducation: result[1].map(
            (res) =>
            new DropdownModel({
              value: res.educationtypekey,
              text: res.typedescription
              })
          ),
          states: result[2].map(
            (res) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          ),
          lastGrade: result[3].map(
            (res) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.gradetypekey
              })
          ),
          currentGrade: result[4].map(
            (res) =>    // NOSONAR
              new DropdownModel({ // This function has 2 lines of dupliate code. Hence, marked it as No sonar
                text: res.typedescription,
                value: res.gradetypekey
              })
          ),
          testingType: result[5].map(
            (res) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.testingtypekey
              })
          )
        };
      }),
      share(),);
    this.schoolTypeDropdownItems$ = source.pipe(pluck('schoolType'));
    this.specialEducationDropdownItems$ = source.pipe(pluck('specialEducation'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.lastGradeDropdownItems$ = source.pipe(pluck('lastGrade'));
    this.currentGradeDropdownItems$ = source.pipe(pluck('currentGrade'));
    this.testingTypeDropdownItems$ = source.pipe(pluck('testingType'));
  }

  loadSchoolDropdown() {
    const searchkey = this.schoolForm.get('educationname')?.value;
    const headers = new HttpHeaders().set('no-loader', 'true');
    let schoolUrl = '';
    
    schoolUrl =  this.baseUrl + '/' + CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.GetSchoolUrl;
    
    this.schoolSearchList$ = this.http.get(schoolUrl + '?filter=' + JSON.stringify({ where: {
        searchkey: searchkey
      },
      nolimit: true, method: 'get'
    }), { headers: headers }).pipe(map((result) => {
      return result;
    }));
  }


  specialEducation(specialEdu: any) {
    if (specialEdu === 'true' || specialEdu === true) {
      this.isSpecialEducation = true;
    } else {
      this.isSpecialEducation = false;
    }
  }

}
