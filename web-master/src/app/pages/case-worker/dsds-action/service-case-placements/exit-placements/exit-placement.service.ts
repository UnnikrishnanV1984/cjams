import { Injectable } from '@angular/core';
import { CommonDropdownsService, CommonHttpService } from '../../../../../@core/services';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';

@Injectable({
  providedIn:'root'
})
export class ExitPlacementService {


  exitPlacementForm!: FormGroup;
  voidPlacementForm!: FormGroup;
  minExitDate: any;

  constructor(private _commonDropDownService: CommonDropdownsService,
   private formBuilder: FormBuilder,
    private _commonService: CommonHttpService,) {

  }

  getExitTypes() {
    return this._commonDropDownService.getDropownsByTable('placement_exit_type');
  }

  getReasonForExit(exitType:any) {
    return this._commonDropDownService.getDropownsByTable(exitType);
  }

  getVoidReasonTypes() {
    return this._commonDropDownService.getListByTableID(82);
  }

  initializeExitForm() {
    this.exitPlacementForm = this.formBuilder.group({
      exittypekey: [null],
      exitreasontypekey: [null,Validators.required],
      remarks: [null],
      leastrestrictiveplacement: [null],
      enddate: [null, Validators.required],
      endtime: [null, Validators.required],
      transferagency :[null],
      otherpublicagency :[null],
      placementdisposableortrashbag :[null],
      ladisposableortrashbag:[null],
      exitluggage: [null], 
      exitluggageprovided :[null],
      exitluggagecomments :[null],
      exitdisposableortrashbag: [null]
    });
  }

  initializeVoidForm() {
    this.voidPlacementForm = this.formBuilder.group({
      voidreasontypekey: [null],
      voidremarks: [null, [Validators.required, Validators.maxLength(1000)]],
      leastrestrictiveplacement: [null],
      voiddate: [null]
    });
  }

  getFormInstance() {
    this.initializeExitForm();
    return this.exitPlacementForm;
  }

  getVoidPlacementFormInstance() {
    this.initializeVoidForm();
    return this.voidPlacementForm;
  }

getreasontype() {
  return this._commonService.getArrayList(
    {
      where: { referencetypeid: '343', teamtypekey: 'CW'},
      method: 'get'
    },
    CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetAllTypesList +
    '?filter'
    )
}
gettransferagency() {
  return this._commonService.getArrayList(
    {
      where: { referencetypeid: '350', teamtypekey: 'CW' },
      method: 'get'
    },
    CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetAllTypesList +
    '?filter'
  )
}
}
