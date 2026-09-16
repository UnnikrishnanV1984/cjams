// <reference types="dwt" />
import { Component, OnInit, ViewChild } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { NgForm } from '@angular/forms';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { NgxfUploaderService } from 'ngxf-uploader';
import { ActivatedRoute } from '@angular/router';
import { AuthService,SessionStorageService  } from '../../../../@core/services';
import { AttachmentDetailComponent } from '../attachment-detail/attachment-detail.component';
import { FileUtils } from '../../../../@core/common/file-utils';
import { AppConfig } from '../../../../app.config';
import { NewUrlConfig } from '../../newintake-url.config';

declare var $: any;
declare var Dynamsoft: any;
declare var EnumDWT_ImageType: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'scan-attachment',
    templateUrl: './scan-attachment.component.html',
    styleUrls: ['./scan-attachment.component.scss'],
    standalone: false
})
export class ScanAttachmentComponent implements OnInit {
  intakeNumber: string;
  id: string;
  daNumber: string;
  tabActive = false;
  DW_CurrentImage : any;
  DW_TotalImage:any;
  
  private token: AppUser;

  /*Dynamo Soft */
  dwObject: any;
  fileName: string;
  isFileScanned: boolean;
  docNames: any;
  myData: any;
  fileExistsMsg: any;
  isUploading: boolean = false;
  disableScanBtn: boolean = false;

  showDialog: boolean;
  img_width: string;
  img_height: string;
  selectedInterpolation: number;
  _iLeft: any;
  _iTop: any;
  _iRight: any;
  _iBottom: any;
  DW_PreviewMode: any;
  isAttachDetail: boolean = false;
  dwtIntakeNo: any;

  @ViewChild(AttachmentDetailComponent) attachmentDetail: AttachmentDetailComponent;

  constructor(private route: ActivatedRoute, private _uploadService: NgxfUploaderService, private _authService: AuthService,private _storage: SessionStorageService) {
    this.id = route.snapshot.parent.parent.parent.parent.parent.params['id'];
    this.daNumber = route.snapshot.parent.parent.parent.parent.parent.params['daNumber'];
    this.token = this._authService.getCurrentUser();
    this.token = this._authService.getCurrentUser();
    this.docNames = [];
  }

  ngOnInit() {
    $('#upload-scan-attachment').modal('show');
    Dynamsoft.WebTwainEnv.Load();
    Dynamsoft.WebTwainEnv.Trial = false;
    Dynamsoft.WebTwainEnv.ProductKey = decodeURIComponent(atob(this._storage.getItem('dynamsoftProductKey')))  ? decodeURIComponent(atob(this._storage.getItem('dynamsoftProductKey'))):null;
    Dynamsoft.WebTwainEnv.ResourcesPath = 'assets/images/dwt/scanner';
  }

  ngOnDestroy() {
    Dynamsoft.DWT.Unload();
  }

  modalDismiss() {
    $('#upload-scan-attachment').modal('hide');
  }

  acquireImage(): void {
    this.dwObject = Dynamsoft.DWT.GetWebTwain('dwtcontrolContainer');
    this.dwObject.RegisterEvent("OnTopImageInTheViewChanged", this.Dynamsoft_OnTopImageInTheViewChanged);
    this.dwObject.RegisterEvent("OnMouseClick", this.Dynamsoft_OnMouseClick);
    this.dwObject.RegisterEvent("OnPostTransfer", this.Dynamsoft_OnPostTransfer);
    this.dwObject.RegisterEvent("OnPostLoad", this.Dynamsoft_OnPostLoadfunction);
    this.dwObject.RegisterEvent("OnPostAllTransfers", this.Dynamsoft_OnPostAllTransfers);
    this.dwObject.RegisterEvent("OnImageAreaSelected", this.Dynamsoft_OnImageAreaSelected);
    this.dwObject.RegisterEvent("OnImageAreaDeSelected", this.Dynamsoft_OnImageAreaDeselected);
    this.dwObject.RegisterEvent("OnGetFilePath", this.Dynamsoft_OnGetFilePath);
    const bSelected = this.dwObject.SelectSource();
    if (bSelected) {
      const onAcquireImageSuccess = () => {
        this.isFileScanned = true;
        this.dwObject.ConvertToBlob([0], EnumDWT_ImageType.IT_PDF, (res) => {
          this.updatePageInfo();
        });
        this.disableScanBtn = true;
      };
      const onAcquireImageFailure = onAcquireImageSuccess;
      this.dwObject.OpenSource();
      this.dwObject.AcquireImage({}, onAcquireImageSuccess, onAcquireImageFailure);
    }
  }

  uploadScanDocument() {
    this.isAttachDetail = true;
    var scanDocs = [];
    var len = this.dwObject.HowManyImagesInBuffer;
    if (len == 0) {
      scanDocs.push(0);
    } else {
      for (let i = 0; i < len; i++) {
        scanDocs.push(i);
      }
    }
    this.dwObject.ConvertToBlob(scanDocs, Dynamsoft.DWT.EnumDWT_ImageType.IT_PDF, (res) => {
      const fileName = FileUtils.getFileName('pdf');
      const fileObject = new File([res], fileName, {
        type: 'application/pdf'
      });
      let uploadUrl = '';
      
        uploadUrl = AppConfig.baseUrl + '/' + NewUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber;
      


      this._uploadService
        .upload({
          url: uploadUrl,
          headers: new HttpHeaders().set('ctype', 'file'),
          filesKey: ['file'],
          files: fileObject,
          process: true
        })
        .subscribe(
          (response) => {
            if (response.data) {
              this.attachmentDetail.patchAttachmentDetail(response.data);
              this.attachmentDetail.loadDropdown();
              this.tabActive = true;
              $('#step1').removeClass('active');
              $('#complete').addClass('active');
            }
          });
    });

  }

  checkIfImagesInBuffer() {
    if (this.dwObject !== undefined) {
      return (this.dwObject.HowManyImagesInBuffer !== 0);
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
        btnCrop1.onclick = function () {
          this.btnCrop_onclick()
        }.bind(this);
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

  private Dynamsoft_OnMouseClick = function Dynamsoft_OnMouseClick(index) {
    this.updatePageInfo();
  }.bind(this);

  private Dynamsoft_OnPostTransfer = function Dynamsoft_OnPostTransfer() {
    this.updatePageInfo();
  }.bind(this);

  private Dynamsoft_OnPostLoadfunction = function Dynamsoft_OnPostLoadfunction(path, name, type) {
    this.updatePageInfo();
  }.bind(this);

  private Dynamsoft_OnPostAllTransfers = function Dynamsoft_OnPostAllTransfers() {
    if (this.dwObject !== undefined) {
      this.dwObject.CloseSource();
    }
    this.updatePageInfo();
  }.bind(this);

  private Dynamsoft_OnTopImageInTheViewChanged = function Dynamsoft_OnTopImageInTheViewChanged(index) {
    this._iLeft = 0;
    this._iTop = 0;
    this._iRight = 0;
    this._iBottom = 0;
    this.dwObject.CurrentImageIndexInBuffer = index;
    this.updatePageInfo();
  }.bind(this);

  private Dynamsoft_OnImageAreaSelected = function Dynamsoft_OnImageAreaSelected(index, left, top, right, bottom) {
    this._iLeft = left;
    this._iTop = top;
    this._iRight = right;
    this._iBottom = bottom;
  }.bind(this);

  private Dynamsoft_OnImageAreaDeselected = function Dynamsoft_OnImageAreaDeselected(index) {
    this._iLeft = 0;
    this._iTop = 0;
    this._iRight = 0;
    this._iBottom = 0;
  }.bind(this);

  private Dynamsoft_OnGetFilePath = function Dynamsoft_OnGetFilePath(bSave, count, index, path, name) {
    // No content to add or call
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
    let j: number;
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
