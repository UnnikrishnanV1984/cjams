import { Component, OnInit, EventEmitter, Input, Output } from '@angular/core';
import { AuthService, CommonHttpService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { NavigationUtils } from '../../../../_utils/navigation-utils.service';

@Component({
    selector: 'profile-image-upload',
    templateUrl: './profile-image-upload.component.html',
    styleUrls: ['./profile-image-upload.component.scss'],
    standalone: false
})
export class ProfileImageUploadComponent implements OnInit {

  url: string='';
  token!: AppUser;
  daNumber: string='';
  personid= '';
  attachmenttype:string= 'case';
  public imagePath:any ='';
  @Output() uploadimagedata: EventEmitter<any> = new EventEmitter<any>();
  imgURL: any;
  private hasPhotoFromUpload = false;

  // Photo saved on the person record - used when there is no attachment record to load from
  @Input() set personphoto(value: string) {
    if (!this.hasPhotoFromUpload && value) {
      this.imgURL = value;
    }
  }

  constructor(
    private _authService: AuthService,
    private navUtil: NavigationUtils,
    private _commonHttpService: CommonHttpService
    ) {
    this.token = this._authService.getCurrentUser();
    const requestParam = this.navUtil.getPersonRequestParam();
    if (requestParam.intakenumber) {
      this.daNumber = requestParam.intakenumber;
    } else if (requestParam.servicecaseid) {
      this.daNumber = requestParam.servicecaseid;
    } else if (requestParam.intakeserviceid) {
      this.daNumber = requestParam.intakeserviceid;
    } else if (requestParam.objectid) {
      this.daNumber = requestParam.objectid;
    }

    if (requestParam ) {
      this.attachmenttype = 'person';
      this.personid = requestParam.personid;
    }
  }

  ngOnInit() {
    this.imgURL = this.imgURL ? this.imgURL : '';
     this.getProfileByPersonID();
  }
  async getProfileByPersonID() {
    this._commonHttpService.getArrayList(
      {
        nolimit: true,
        where: { personId : this.personid}, method: 'get'
      },
      'Documentproperties/getPersonAttachmentByPersonId?filter'
  ) .subscribe(
    (resultresp) => {
      if (resultresp && Array.isArray(resultresp) && resultresp.length > 0) {
      this.downloadFile(resultresp[0].s3bucketpathname);
      }
    });
  }

  onAttachmentChange(event: any) {
    const reader = new FileReader();
    if (event.target.files && event.target.files.length) {
        const [file] = event.target.files;
        this.preview(file);
        reader.readAsDataURL(file);
        reader.onload = () => {
          const data = {'s3bucketpathname': reader.result};
          this.uploadimagedata.emit(data);
        };
    }
  }

  preview(files: any) {
    this.imgURL = '';
    const mimeType = files.type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    const reader = new FileReader();
    this.imagePath = files;
    reader.readAsDataURL(files);
    reader.onload = (_event) => {
      this.imgURL = reader.result;
    }
  }

  downloadFile(s3bucketpathname: string) {
    if (!s3bucketpathname) {
      return;
    }
    // An inline data/blob source is already complete - only relative paths need the api host
    this.imgURL = this.isInlineSource(s3bucketpathname) ? s3bucketpathname : AppConfig.baseUrl + s3bucketpathname;
  }

  private isInlineSource(url: string): boolean {
    return /^(data:|blob:)/i.test(url);
  }
  
}
