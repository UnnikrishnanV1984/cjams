import { Component, OnInit, ViewChild, Input, Output, EventEmitter } from '@angular/core';
import { NgForm } from '@angular/forms';
import { AppUser } from '../../../@core/entities/authDataModel';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService, CommonHttpService, DataStoreService,SessionStorageService  } from '../../../@core/services';
import { AttachementScanDetailComponent } from  "../attachement-scan-detail/attachement-scan-detail.component"//"../../../pages/case-worker/dsds-action/attachment/attachment-detail/attachment-detail.component"  // '../attachment-detail/attachment-detail.component';
import { FileUtils } from '../../../@core/common/file-utils';
import { AppConfig } from '../../../app.config';
import moment from 'moment';
import { CASE_STORE_CONSTANTS } from "../../../pages/case-worker/_entities/caseworker.data.constants"; //'../../../_entities/caseworker.data.constants';


declare var $: any;
declare var Dynamsoft: any;
declare var EnumDWT_ImageType: any;

@Component({
    selector: 'scan-shared-attachement',
    templateUrl: './scan-shared-attachement.component.html',
    styleUrls: ['./scan-shared-attachement.component.scss'],
    standalone: false
})
export class ScanSharedAttachementComponent implements OnInit {
  @Input()
  intakeNumber!: string;
  @Output() dismissModal = new EventEmitter();
  id: string;
  daNumber: string;
  isServiceCase: any;
  tabActive = false;

  attachmenttype='case';
  personid='';
  private token: AppUser;

  /*Dynamo Soft */
  dwObject: any;
  fileName!: string;
  isFileScanned!: boolean;
  docNames: any;
  myData: any;
  fileExistsMsg: any;
  isUploading: boolean = false;
  disableScanBtn: boolean = false;

  showDialog?: boolean;
  img_width!: string;
  img_height!: string;
  selectedInterpolation?: number;
  _iLeft: any;
  _iTop: any;
  _iRight: any;
  _iBottom: any;
  DW_PreviewMode: any;
  isAttachDetail: boolean = false;
  dwtIntakeNo: any;
  containerId = 'dwtcontrolContainer';
  isMounted = false;

  @ViewChild(AttachementScanDetailComponent)
  attachmentDetail!: AttachementScanDetailComponent;

  constructor(private route: ActivatedRoute, private _authService: AuthService,
    private _dataStoreService: DataStoreService,private _storage: SessionStorageService,
    private router: Router,) {

    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);

    this.token = this._authService.getCurrentUser();
    this.token = this._authService.getCurrentUser();
    this.docNames = [];
    if(route.snapshot.params) {
      this.attachmenttype = route.snapshot.params['attachmenttype'] || 'case';
      this.personid = route.snapshot.params['personid'] || '';
  }
  }

  ngOnInit() {
    $('#upload-scan-attachment').modal('show');
    console.log("involked");
    Dynamsoft.DWT.Containers = [{
      WebTwainId: 'dwtObject',
      ContainerId: this.containerId,
      Width: '500px',
      Height: '390px'
    }];

    Dynamsoft.DWT.ProductKey = decodeURIComponent(atob(this._storage.getItem('dynamsoftProductKey')))  ? decodeURIComponent(atob(this._storage.getItem('dynamsoftProductKey'))):null;
    Dynamsoft.DWT.ResourcesPath = 'assets/images/dwt/scanner';
    Dynamsoft.DWT.RegisterEvent('OnWebTwainReady', () => this.onWebTwainReady());
    Dynamsoft.DWT.Trial = false;
    Dynamsoft.DWT.Load();
  }

  onWebTwainReady() {
    this.dwObject = Dynamsoft.DWT.GetWebTwain(this.containerId);
    this.isMounted = true;
  }

  ngOnDestroy() {
    Dynamsoft.DWT.Unload();
  }

  modalDismiss() {
    this.dismissModal.emit()
  }

  unMountDWT() {
    if (!this.isMounted) return;
    try {
      if (this.dwObject) {
          this.dwObject.CloseSource();
          this.dwObject.RemoveAllImages();
        }

        Dynamsoft.DWT.Unload();

        const container = document.getElementById(this.containerId);
        if (container) container.innerHTML = '';

        this.dwObject = null;
        this.isMounted = false;
    } catch (error) {
      console.error('Error during unmount:', error);
    }
  }

  private registerEvents(): void {
    this.dwObject.RegisterEvent('OnMouseClick', (index: number) => {
      this.updatePageInfo();
    });

    this.dwObject.RegisterEvent('OnPostTransfer', () => {
      this.updatePageInfo();
    });

    this.dwObject.RegisterEvent('OnPostLoad', (path: string, name: string, type: number) => {
      this.updatePageInfo();
    });

    this.dwObject.RegisterEvent('OnPostAllTransfers', () => {
      if (this.dwObject) {
        this.dwObject.CloseSource();
      }
      this.updatePageInfo();
    });

    this.dwObject.RegisterEvent('OnTopImageInTheViewChanged', (index: number) => {
      this._iLeft = 0;
      this._iTop = 0;
      this._iRight = 0;
      this._iBottom = 0;
      this.updatePageInfo();
    });

    this.dwObject.RegisterEvent('OnImageAreaSelected', (index: number, left: number, top: number, right: number, bottom: number) => {
      this._iLeft = left;
      this._iTop = top;
      this._iRight = right;
      this._iBottom = bottom;
    });

    this.dwObject.RegisterEvent('OnImageAreaDeselected', (index: number) => {
      this._iLeft = 0;
      this._iTop = 0;
      this._iRight = 0;
      this._iBottom = 0;
    });

    this.dwObject.RegisterEvent('OnGetFilePath', (bSave: boolean, count: number, index: number, path: string, name: string) => {
      // Optional: handle file path logic
    });
  }

  acquireImage(): void {
    if (!this.dwObject) {
      return;
    }

    try {
      this.dwObject.Viewer.bind(document.getElementById('dwtcontrolContainer'));
      this.registerEvents();
      const bSelected = this.dwObject.SelectSource();
      if (bSelected) {
          const onAcquireImageSuccess = () => {
            this.isFileScanned = true;
                  this.dwObject.ConvertToBlob([0], Dynamsoft.DWT.EnumDWT_ImageType.IT_PDF, (res:any) => {
              console.log('****' + res.size);
              this.updatePageInfo();
            }, (num:any, err:any) => {
              console.log('error is ' + err);
            });
            this.disableScanBtn = true;
          };
          const onAcquireImageFailure = onAcquireImageSuccess;
          this.dwObject.OpenSource();
          this.dwObject.AcquireImage({}, onAcquireImageSuccess, onAcquireImageFailure);
        }
        this.updateViewer();
    } catch (error) {
      console.error('Error during scan:', error);
    }
    }
  
    updateViewer() {
  
      if (this.dwObject) {
        this.dwObject.Viewer.show();
  
        return true;
      }
  
      return false;
    }

  uploadScanDocument() {
    if(!this.dwObject) {
      return;
    }
    this.isAttachDetail = true;
    let scanDocs: any[] = [];
    let len = this.dwObject.HowManyImagesInBuffer;
    if (len == 0) {
      scanDocs.push(0);
    } else {
      for (let i = 0; i < len; i++) {
        scanDocs.push(i);
      }
    }
    this.dwObject.ConvertToBlob(scanDocs, Dynamsoft.DWT.EnumDWT_ImageType.IT_PDF, async(res:any) => {
      const fileName = FileUtils.getFileName('pdf');
      const fileObject = new File([res], fileName, {
        type: 'application/pdf'
      });
      const uploadParams = this.getUploadParams(fileObject);
      this.attachmentDetail.patchAttachmentDetail(uploadParams, fileObject,this.attachmenttype,this.personid);
      this.attachmentDetail.loadDropdown();
      this.tabActive = true;
      $('#step1').removeClass('active');
      $('#complete').addClass('active');
      });

  }

   private getUploadParams(file: any){
        const size = this.humanizeBytes(file.size);
        const filename = file.name;
        const securityuserid = this.token.user.userprofile.securityusersid;
        const isactualDocDate = moment(new Date()).format('MM/DD/YYYY');
        const documentParams = {
            attachmenttype: this.attachmenttype,
            insertedby: securityuserid,
            actualdocumentdate: isactualDocDate,
            description: '',
            other: '',
            filename: filename,
            filesize: size,
            deletedocid: ''
        };
        if (this.daNumber === undefined || this.daNumber === null) {
            return {
                srno: this.intakeNumber,
                ...documentParams
            };
        }
        return {
            srno: this.daNumber,
            objectid: this.id,
            ...(this.isServiceCase ? { servicecaseid: this.id } : { servicerequestid: this.id }),
            objecttypekey: this.isServiceCase ? 'Servicecase' : 'ServiceRequest',
            ...documentParams
        };
    }

    humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return '0 Byte';
        }
        const k = 1024;
        const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

  checkIfImagesInBuffer() {
    if (this.dwObject !== undefined) {
      return this.dwObject.HowManyImagesInBuffer !== 0;
    }
  }

  updatePageInfo() {
    if (document.getElementById("DW_TotalImage")) {
      (<HTMLInputElement>document.getElementById("DW_TotalImage")).value = this.dwObject.HowManyImagesInBuffer + "";
    }
    const currImgIndex: number = this.dwObject.CurrentImageIndexInBuffer + 1;
    if (document.getElementById("DW_CurrentImage")) {
      (<HTMLInputElement>document.getElementById("DW_CurrentImage")).value = currImgIndex + "";
    }
  }
  //************************** Edit Image ******************************
  btnShowImageEditor_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.ShowImageEditor();
  }

  btnRotateLeft_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.RotateLeft(this.dwObject.CurrentImageIndexInBuffer);
  }

  btnRotateRight_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.RotateRight(this.dwObject.CurrentImageIndexInBuffer);
  }

  btnRotate180_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.Rotate(this.dwObject.CurrentImageIndexInBuffer, 180, true);
  }

  btnMirror_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.Mirror(this.dwObject.CurrentImageIndexInBuffer);
  }

  btnFlip_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.Flip(this.dwObject.CurrentImageIndexInBuffer);
  }

  btnRemoveCurrentImage_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.RemoveAllSelectedImages();
    if (this.dwObject.HowManyImagesInBuffer == 0) {
      if (document.getElementById("DW_TotalImage")) {
        (<HTMLInputElement>document.getElementById("DW_TotalImage")).value = this.dwObject.HowManyImagesInBuffer + "";
        this.isFileScanned = false;
      }
      if (document.getElementById("DW_CurrentImage")) {
        (<HTMLInputElement>document.getElementById("DW_CurrentImage")).value = 0 + "";
      }
    } else {
      this.updatePageInfo();
    }
  }

  btnRemoveAllImages_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.RemoveAllImages();
    this.isFileScanned = false;
    if (document.getElementById("DW_TotalImage")) {
      (<HTMLInputElement>document.getElementById("DW_TotalImage")).value = 0 + "";
    }
    if (document.getElementById("DW_CurrentImage")) {
      (<HTMLInputElement>document.getElementById("DW_CurrentImage")).value = 0 + "";
    }
  }
  /*----------------Change Image Size--------------------*/
  btnChangeImageSize_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    if (this.dwObject !== undefined) {
      this.showDialog = true;
      this.img_width = this.dwObject.GetImageWidth(this.dwObject.CurrentImageIndexInBuffer) + "";
      this.img_height = this.dwObject.GetImageHeight(this.dwObject.CurrentImageIndexInBuffer) + "";
    } else {
      alert("Please scan a document");
      this.showDialog = false;
    }
  }

  btnChangeImageSizeOK_onclick(changeImageSizeForm: NgForm) {
    this.dwObject.ChangeImageSize(this.dwObject.CurrentImageIndexInBuffer, parseInt(this.img_width), parseInt(this.img_height), this.selectedInterpolation);
    this.showDialog = false;
  }

  selectInterpolcationChangeHandler(event: any) {
    this.selectedInterpolation = event.target.value;
  }

  /*----------------Crop Image--------------------*/
  btnCrop_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    if (this._iLeft != 0 || this._iTop != 0 || this._iRight != 0 || this._iBottom != 0) {
      this.dwObject.Crop(
        this.dwObject.CurrentImageIndexInBuffer,
        this._iLeft, this._iTop, this._iRight, this._iBottom
      );
      this._iLeft = 0;
      this._iTop = 0;
      this._iRight = 0;
      this._iBottom = 0;
    } else {
      alert("Please select the area you'd like to crop");
    }
  }

  /* Navigator Dynamo Soft*/
  setlPreviewMode() {
    let varNum = (<HTMLSelectElement>document.getElementById("DW_PreviewMode")).selectedIndex;
    varNum = varNum + 1;
    const btnCrop1 = (<HTMLImageElement>document.getElementById("btnCrop"));
    if (btnCrop1) {
      var tmpstr = btnCrop1.src;
      if (varNum > 1) {
        tmpstr = tmpstr.replace('Crop.', 'Crop_gray.');
        btnCrop1.src = tmpstr;
        btnCrop1.onclick = function () {
          // No content to add or call
        };
      }
      else {
        tmpstr = tmpstr.replace('Crop_gray.', 'Crop.');
        btnCrop1.src = tmpstr;
        btnCrop1.onclick = ()=> {
          this.btnCrop_onclick()
        };
      }
    }
    this.dwObject.SetViewMode(varNum, varNum);
    if (Dynamsoft.Lib.env.bMac || Dynamsoft.Lib.env.bLinux) {
      return;
    } else if (this.DW_PreviewMode.selectedIndex !== 0) {
      this.dwObject.MouseShape = true;
    } else {
      this.dwObject.MouseShape = false;
    }
  }

  btnFirstImage_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.CurrentImageIndexInBuffer = 0;
    this.updatePageInfo();
  }

  btnLastImage_onclick() {
    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    const k: number = this.dwObject.HowManyImagesInBuffer - 1;
    this.dwObject.CurrentImageIndexInBuffer = k;
    this.updatePageInfo();
  }
  btnPreImage_onclick() {
    this.dwObject.CurrentImageIndexInBuffer = this.dwObject.CurrentImageIndexInBuffer - 1;
    this.updatePageInfo();
  }

  btnNextImage_onclick() {
    let j!: number;
    if (this.dwObject !== undefined) {
      j = this.dwObject.CurrentImageIndexInBuffer;
    }

    if (!this.checkIfImagesInBuffer()) {
      return;
    }
    this.dwObject.CurrentImageIndexInBuffer = j + 1;
    this.updatePageInfo();
  }

  btnPreImage_wheel() {
    if (this.dwObject.HowManyImagesInBuffer !== 0){
      this.btnPreImage_onclick();}
  }
  btnNextImage_wheel() {
    if (this.dwObject.HowManyImagesInBuffer !== 0){
      this.btnNextImage_onclick();}
  }
  }
