import { ChangeDetectorRef, Component, OnInit, AfterViewChecked, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';

import { NgxfUploaderService } from 'ngxf-uploader';
import { HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserProfileImage } from '../../../../@core/common/models/involvedperson.data.model';
import { AuthService, AlertService, CommonDropdownsService } from '../../../../@core/services';
import { PersonDetailsService } from '../../person-details.service';
import { PersonBasicDetailsService } from '../person-basic-details.service';
import { AppConstants } from '../../../../@core/common/constants';
import { AppConfig } from '../../../../app.config';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';

@Component({
    selector: 'person-demographics',
    templateUrl: './person-demographics.component.html',
    styleUrls: ['./person-demographics.component.scss'],
    standalone: false
})
export class PersonDemographicsComponent implements OnInit, AfterViewChecked {

  involvedPersonFormGroup!: FormGroup;

  genderDropdownItems$!: Observable<any[]>;
  stateDropdownItems$!: Observable<any[]>;
  nationalOriginList$!: Observable<any[]>;
  ethinicityDropdownItems$!: Observable<any[]>;
  religionDropdownItems$!: Observable<any[]>;
  raceDropdownItems$!: Observable<any[]>;
  maritalDropdownItems$!: Observable<any[]>;
  finalImage!: File;
  personid!: string | null | undefined;
  maxDate = new Date();
  imageChangedEvent: Event | null = null;
  croppedImage!: File;
  isImageHide!: boolean;
  errorValidateAddress = false;
  beofreImageCropeHide = false;
  afterImageCropeHide = false;
  isDefaultPhoto = true;
  isImageLoadFailed = false;
  editImage = true;
  userProfilePicture!: UserProfileImage;
  userProfile!: string;
  editImagesShow!: string;
  isDjs = false;
  progress: { percentage: number | undefined } = { percentage: 0 };
  selectedDob!: Date;
  currentdate = new Date();
  youthAge!: string;
  personNameSuffix$!: Observable<any[]>;

  private route: ActivatedRoute;
  private _authService: AuthService;
  private _alertService: AlertService;
  private _formBuilder: FormBuilder;
  public personService: PersonDetailsService;
  private dropdownService: CommonDropdownsService;
  private _basicDetailsService: PersonBasicDetailsService;
  private _uploadService: NgxfUploaderService;
  private cdRef: ChangeDetectorRef;

  constructor(private injector:Injector){
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.personService = this.injector.get<PersonDetailsService>(PersonDetailsService);
    this.dropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._basicDetailsService = this.injector.get<PersonBasicDetailsService>(PersonBasicDetailsService);
    this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
    this.cdRef = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
 }

  ngOnInit() {
    this.isDjs = this._authService.isDJS();
    this.personid = this.route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
    this.initiateFormGroup();
    if (this.involvedPersonFormGroup.get('Dob')?.valueChanges) {
      this.dobChange();
    }
    if (this.personService.isEditable) {
      this.involvedPersonFormGroup.enable();
      this.involvedPersonFormGroup.get('cjamspid')?.disable();
      this.involvedPersonFormGroup.get('assistpid')?.disable();
    } else {
      setTimeout(() => {
        this.involvedPersonFormGroup.disable();
      }, 100);
    }
    this.loadDropdowns();
    this.loadPersonInfo();
  }
  public findInvalidControls() {
    const invalid = [];
    const controls = this.involvedPersonFormGroup.controls;
    for (const name in controls) {
      if (controls[name].invalid) {
        invalid.push(controls[name]);
      }
    }
   
    return invalid;
  }

  private loadPersonInfo() {
    this.personService.getPersonDetails(this.personid).subscribe(response => {
      this.personService.person = response;
      this.patchForm();
      this.findInvalidControls();
    });
  }

  private initiateFormGroup() {
    this.involvedPersonFormGroup = this._formBuilder.group({
      personid: new FormControl(''),
      Lastname: ['', Validators.required],
      Firstname: ['', Validators.required],
      Middlename: new FormControl(''),
      nameSuffix: new FormControl(''),
      Dob: [Validators.required],
      Dod: new FormControl(null),
      gendertypekey: ['', Validators.required],
      religiontypekey: new FormControl(''),
      maritalstatustypekey: new FormControl(''),
      SSN: new FormControl(''),
      ethnicgrouptypekey: new FormControl(''),
      occupation: new FormControl(''),
      stateid: new FormControl(''),
      dl: new FormControl(''),
      cjamspid: new FormControl(''),
      assistpid: new FormControl(''),
      Race: new FormControl(''),
      Ethicity: new FormControl(''),
      tribalassociation: new FormControl(''),
      height: new FormControl(''),
      weight: new FormControl(''),
      tattoo: new FormControl(''),
      PhyMark: new FormControl(''),
      needs: new FormControl(''),
      strengths: new FormControl(''),
      userphoto: new FormControl(''),
      nationalitytypekey: new FormControl('')
    });
    if (this.isDjs) {
      this.involvedPersonFormGroup.get('Race')?.setValidators([Validators.required]);
      this.involvedPersonFormGroup.get('Race')?.updateValueAndValidity();
      this.involvedPersonFormGroup.get('Ethicity')?.setValidators([Validators.required]);
      this.involvedPersonFormGroup.get('Ethicity')?.updateValueAndValidity();
    }
    this.involvedPersonFormGroup.addControl('names', this._formBuilder.array([]));
  }

  patchForm() {
    this.involvedPersonFormPatchDataFn();
    if (this.personService?.person?.dob) {
      const dateOfBirth = new Date(this.personService.person.dob);
      dateOfBirth.setMinutes( dateOfBirth.getMinutes() + dateOfBirth.getTimezoneOffset() );
      this.involvedPersonFormGroup.patchValue({ Dob: dateOfBirth });
    }

    if (this.personService?.person?.dateofdeath) {
      const dateOfDeath = new Date(this.personService.person.dateofdeath);
      dateOfDeath.setMinutes( dateOfDeath.getMinutes() + dateOfDeath.getTimezoneOffset() );
      this.involvedPersonFormGroup.patchValue({ Dod: dateOfDeath });
    }
    if (this.personService?.person?.personidentifier?.length) {
      this.personidentifierIfCondFn();
    }
    if (this.personService?.person?.personphysicalattribute?.length) {
      this.personphysicalattributeIfCondFn();
    }
    if (this.personService?.person?.userphoto) {
      this.userProfile = this.personService.person.userphoto;
      this.editImagesShow = this.personService.person.userphoto;
    } else {
      this.userProfile = 'assets/images/ic_silhouette.png';
      this.editImagesShow = 'assets/images/ic_silhouette.png';
    }
    if (this.isDjs) {
      this.getAgeInYearsAndMonth(this.currentdate, this.personService.person.dob);
    }
  }

  private personidentifierIfCondFn() {
    const ssn = this.personService.findPersonIdentifier(this.personService.person.personidentifier, AppConstants.PERSON_IDENTIFIER.SSN);
    const DL = this.personService.findPersonIdentifier(this.personService.person.personidentifier, AppConstants.PERSON_IDENTIFIER.DRIVING_LICENSE);
    if (ssn) {
      this.involvedPersonFormGroup.patchValue({ SSN: ssn });
    }
    if (DL) {
      this.involvedPersonFormGroup.patchValue({ dl: DL });
    }
  }

  private personphysicalattributeIfCondFn() {
    const height = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.HEIGHT);
    const weight = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.WEIGHT);
    const tattoo = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.TATTOO);
    const physicalMark = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.PHYSICAL_MARK);
    if (height) {
      this.involvedPersonFormGroup.patchValue({ height: height });
    }
    if (weight) {
      this.involvedPersonFormGroup.patchValue({ weight: weight });
    }
    if (tattoo) {
      this.involvedPersonFormGroup.patchValue({ tattoo: tattoo });
    }
    if (physicalMark) {
      this.involvedPersonFormGroup.patchValue({ PhyMark: physicalMark });
    }
  }

  private involvedPersonFormPatchDataFn() {
    this.involvedPersonFormGroup.patchValue({
      personid: this.personService.person.personid,
      assistpid: this.personService.person.assistpid,
      cjamspid: this.personService.person.cjamspid,
      tribalassociation: this.returnTribalassociationFn(),
      Lastname: this.personService.person ? this.personService.person.lastname : '',
      Firstname: this.personService.person ? this.personService.person.firstname : '',
      Middlename: this.personService.person ? this.personService.person.middlename : '',
      nameSuffix: this.personService.person ? this.personService.person.suffix : '',
      gendertypekey: this.personService.person ? this.personService.person.gendertypekey : '',
      religiontypekey: this.personService.person ? this.personService.person.religiontypekey : '',
      maritalstatustypekey: this.returnMaritalstatustypekeyFn(),
      Race: this.personService.person ? this.personService.person.racetypekey : '',
      Ethicity: this.returnEthicityFn(),
      occupation: this.personService.person ? this.personService.person.occupation : '',
      stateid: this.personService.person ? this.personService.person.stateid : '',
      strengths: this.personService.person ? this.personService.person.strengths : '',
      needs: this.personService.person ? this.personService.person.needs : '',
      nationalitytypekey: this.returnNationalitytypekeyFn(),
      userphoto: this.personService.person.userphoto
    });
  }

  private returnEthicityFn(): any {
    return this.personService.person ? this.personService.person.ethnicgrouptypekey : '';
  }

  private returnTribalassociationFn(): any {
    return this.personService.person ? this.personService.person.tribalassociation : '';
  }

  private returnMaritalstatustypekeyFn(): any {
    return this.personService.person ? this.personService.person.maritalstatustypekey : '';
  }

  private returnNationalitytypekeyFn(): any {
    return this.personService.person ? this.personService.person.nationalitytypekey : '';
  }

  dobChange() {
    this.involvedPersonFormGroup.controls['Dob'].valueChanges.subscribe((res) => {
      if (res) {
        this.selectedDob = new Date(res);
        this.getAgeInYearsAndMonth(this.currentdate, this.selectedDob);
      }
    });

  }

  private getAgeInYearsAndMonth(currentDate: any, youthDob: any) {
    const years = moment().diff(youthDob, 'years', false);
    const totalMonths = moment().diff(youthDob, 'months', false);
    const months = totalMonths - (years * 12);
    
    this.youthAge = `${years} Years ${months} month(s)`;
  }

  private loadDropdowns() {
    this.genderDropdownItems$ = this.dropdownService.getGenders();
    this.stateDropdownItems$ = this.dropdownService.getStateList();
    this.nationalOriginList$ = this.dropdownService.getNationalOriginList();
    this.ethinicityDropdownItems$ = this.dropdownService.getEtinicity();
    this.religionDropdownItems$ = this.dropdownService.getReligions();
    this.raceDropdownItems$ = this.dropdownService.getRaces();
    this.maritalDropdownItems$ = this.dropdownService.getMaritalStatus();
    this.personNameSuffix$ = this.dropdownService.getListByTableID('134');
  }

  updatePerson() {
    if (this.involvedPersonFormGroup.valid) {
      const basicDetails = this.involvedPersonFormGroup.getRawValue();
      basicDetails.Dob = moment(basicDetails.Dob).format('YYYY-MM-DD');
      if (basicDetails.Dod) {
        basicDetails.Dod = moment(basicDetails.Dod).format('YYYY-MM-DD');
      }
      // need to save the relative path
      if (this.userProfilePicture) {
        basicDetails.userphoto = this.userProfilePicture.s3bucketpathname;
      }

      this._basicDetailsService.updateBasicDetails(basicDetails).subscribe(response => {
        this._alertService.success('Person Updated Successfully');
        this.loadPersonInfo();
      });
    }
  }

  ngAfterViewChecked() {
    this.cdRef.markForCheck();
    this.cdRef.detectChanges();
  }
  fileChangeEvent(file: any) {
    this.beofreImageCropeHide = true;
    this.afterImageCropeHide = true;
    this.imageChangedEvent = file;
    this.isDefaultPhoto = false;
    this.isImageLoadFailed = false;
    this.isImageHide = true;
  }
  imageCropped(file: any) {
    this.progress.percentage = 0;
    this.croppedImage = file;
    const imageBase64 = this.croppedImage;
    const blob = this.dataURItoBlob(imageBase64);
    this.finalImage = new File([blob], 'image.png');
    this.saveImage(this.finalImage);
  }
  imageLoaded() {
    // No content to add or call
  }
  loadImageFailed() {
    this.isImageLoadFailed = true;
    this._alertService.error('Image failed to upload');
  }
  dataURItoBlob(dataURI: any) {
    const binary = atob(dataURI.split(',')[1]);
    const array = [];
    for (let i = 0; i < binary.length; i++) {
      array.push(binary.charCodeAt(i));
    }
    return new Blob([new Uint8Array(array)], {
      type: 'image/png'
    });
  }
  saveImage(data: any) {
    this._uploadService
      .upload({
        url: AppConfig.baseUrl + '/' + CommonUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=userprofile',
        headers: new HttpHeaders()
          .set('srno', 'userprofile')
          .set('ctype', 'file'),
        filesKey: ['file'],
        files: data,
        process: true
      })
      .subscribe(
        (response) => {
          if (response.status) {
            this.progress.percentage = response.percent;
          }
          if (response.status === 1 && response.data) {
            this.userProfilePicture = response.data;
          }
        },
        (err) => {
          console.error(err);
        }
      );
  }
}
