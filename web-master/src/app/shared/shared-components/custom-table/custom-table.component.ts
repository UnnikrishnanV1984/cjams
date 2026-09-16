import { AnyNaptrRecord } from 'dns';
import { Action } from './../../modules/web-speech/shared/model/action';
import { Component, OnInit, Injector, Input, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import { AuthService } from '../../../@core/services';

@Component({
    selector: 'custom-table',
    templateUrl: './custom-table.component.html',
    styleUrls: ['./custom-table.component.scss'],
    standalone: false
})
export class CustomTableComponent implements OnInit {

    currentuser: any;
    private authService: AuthService;
    toCheckCurentROle: any;
    @Input() tableData: any;
    @Input() tableDataColumns: any;
    @Input() nestedTableDataColumns: string[] = [];
    @Input() tableDataKeys: any;
    @Input() toolTipMsg: any;
    @Input() gridName = '';
    @Input() editIcon!: boolean;
    @Input() deleteIcon!: boolean;
    @Input() filterIcon: boolean = true;
    @Input() totalpagecount!: number;
    @Input() pageNumber!: number;
    @Input() pageSize: number = 10;
    @Input() isFullHieght!: boolean;
    @Input() styles = null;
    @Input() htmlColumns: string[] = [];
    @Input() isAllchecked: boolean = false;
    @Input() isRequiredSearching: boolean = true;
    @Input() unsortablecolumn:any[] = [];
    @Input() columntextcolor: any;
    @Input() approvalStatus: any;
    @Output() actionEvent: EventEmitter<any> = new EventEmitter();
    @Output() actionPHSEvent: EventEmitter<any> = new EventEmitter();
    @Output() fetchDataEvent: EventEmitter<any> = new EventEmitter();
    @Output() pageChangedEvent: EventEmitter<any> = new EventEmitter();
    @Output() sortEvent: EventEmitter<any> = new EventEmitter();
    @Output() resetEvent: EventEmitter<any> = new EventEmitter();
    @Output() AuthIdEvent: EventEmitter<any> = new EventEmitter();
    @Output() customEvent: EventEmitter<any> = new EventEmitter();
    @Output() actionRoute: EventEmitter<any> = new EventEmitter();
    @Output() IVEActionMethods: EventEmitter<any> = new EventEmitter();
    @Output() CaseClosureApproveAction: EventEmitter<any> = new EventEmitter();
    @Output() searchClosureData: EventEmitter<any> = new EventEmitter();
    @Output() searchFosterData: EventEmitter<any> = new EventEmitter();
    @Output() searchGapData: EventEmitter<any> = new EventEmitter();
    @Output() searchAdoptionData: EventEmitter<any> = new EventEmitter();
    @Output() searchACAData: EventEmitter<any> = new EventEmitter();
    @Output() closureApprovalConfirm: EventEmitter<any> = new EventEmitter();
    filterObj: any = {};
    isReset = false;
    isDialogVisable: boolean = false;
    beaconrequestdetailsid!: string;
    isAwaitingEdit = false;
    @Input() allowTableScrollV = false;
    @Input() columnStyleMap: any[] = [];
    @Input() curentroletypekey: any;
    canAssign: boolean = false;
    showrefilldata:any;
    refilldata: any=[];
    rindex: any;
    collapsebtn: boolean =false;


    constructor(private readonly injector: Injector) {

        this.authService = this.injector.get < AuthService > (AuthService);

    }

    ngOnInit(): void {
        this.currentuser = this.authService?.getCurrentUser();
        const condRole: any = (this.currentuser?.user?.userprofile?.teammemberassignment?.[0]?.teammember?.roletypekey) ? this.currentuser?.user?.userprofile?.teammemberassignment?.[0]?.teammember?.roletypekey : this.currentuser?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
        this.toCheckCurentROle = this.currentuser?.role?.key ? this.currentuser?.role?.key : condRole;
        this.tableDataKeys?.forEach((key: any) => {
            if (key) {
                   this.filterObj[`${key}`] = null
            }
        })
    }

    onSortedFunding(event: any): void {
        this.filterObj = { ...this.filterObj,...event }
        this.sortEvent.emit(JSON.stringify(this.filterObj));
    }

    handleView(event: any) {
        this.actionPHSEvent.emit(JSON.stringify(event));
    }

    renameColumnName(inputData: any): object {
        const { ["Case Number"]: CaseNumber,["Task Status"]: TaskStatus,...rest } = inputData;
        let data;
        if (inputData.hasOwnProperty("Case Number")) {
            data = {
                "Case Numebr": CaseNumber,
                "Status": TaskStatus,
                ...rest
            };
        } else {
            data = {
                "Status": TaskStatus,
                ...rest
            };
        }

        return data;
    }

    handleSearch(event: any): void {
        const inputData = JSON.parse(event);
        const data = this.renameColumnName(inputData);

        this.filterObj = { ...this.filterObj,...data };
        for (let item in this.filterObj) {
            this.filterObj[item] = this.filterObj[item] ? this.filterObj[item].trim() : this.filterObj[item];
        }
        this.fetchDataEvent.emit(JSON.stringify(this.filterObj));
        this.isReset = false;
    }

    handleActionView(event: any, action: any = '',row?: number): void {
        event.action = action;
        event.row =row;
        if(!event?.Action?.dateofrefill){
            this.collapsebtn =false;
        }
        event.personmedicpshychotropicid = event?.Action?.personmedicpshychotropicid;
        this.actionEvent.emit(JSON.stringify(event));
    }

    pageNumberChanged(page: any) {
        this.isAllchecked = false;
        this.pageNumber = page;
        const pageInfo = {
            page: page,
            query: this.filterObj
        }
        this.pageChangedEvent.emit(pageInfo)
    }

    onChange(event: any, data: any) {
        if (!event.checked) {
            this.isAllchecked = false;
        }
        this.customEvent.emit({
            isChecked: event.checked,
            data: data
        });
    }

    onAllSelected() {
        this.customEvent.emit({
            isAllchecked: this.isAllchecked,
            from: 'all',
        });
    }

    openDialog(key: string) {
        this.beaconrequestdetailsid = key;
        this.isDialogVisable = true;
    }

    closeDialog() {
        this.isDialogVisable = false;
    }

    resetFilters() {
        if (this.toolTipMsg === 'Psychotropic Medication list') {
            this.tableDataKeys.forEach((item: any) => {

                this.filterObj[`${item}`] = null

            })
            const data = { 'reset': true };
            this.filterObj = { ...this.filterObj,...data };
        } else {
            this.tableDataKeys.forEach((item: any) => {
                if (item) {
                    this.filterObj[`${item}`] = null
                }
            })
        }

        this.fetchDataEvent.emit(JSON.stringify(this.filterObj));
        this.isReset = true;
        this.filterObj = {};
    }

    handleAuthId(data: any) {
        this.AuthIdEvent.emit(JSON.stringify(data));
    }

    editConfig(data: any) {
        this.isAwaitingEdit = data?.Action?.edituser == this.currentuser?.user?.securityusersid;
        if (data?.Action?.psychotropicid) {
            if (this.toCheckCurentROle == 'CWCW' && ['Draft'].includes(data.status)) {
                return true;
            }
            if (this.toCheckCurentROle == 'CWCW' && ['Returned to Worker'].includes(data.status) && this.currentuser?.user?.securityusersid === data.Action.edituser) {
                return true;
            }
            if (this.toCheckCurentROle == 'CWPSYPHARM' && (['Pending Pharmacist Review','Information Incomplete','Pending Peer To Peer Review'].includes(data.status) && this.isAwaitingEdit)) {
                return true;
            }
            if (this.toCheckCurentROle == 'CWPSYCOORD' && ((['Awaiting Assignment','Information Incomplete','Pending Peer To Peer Review'].includes(data.status) && this.isAwaitingEdit))) {
                return true;
            }
            if (this.toCheckCurentROle == 'CWPSYPSYCH' && ((['Pending CAP Review','Information Incomplete','Pending Peer To Peer Review'].includes(data.status)) && this.isAwaitingEdit)) {
                return true;
            }
            return false;
        } else {
            return false;
        }
    }

    viewConfig(data: any) {
        if(this.toolTipMsg ==='Medication Including Psychotropic'){
if((data?.Action?.medicationexpirationdate || data?.Action?.healthcaredecisionmaker =='LDSS')){
    return false;
}else {return true;}

        } 
        else{
        if (data?.Action?.edituser == this.currentuser?.user?.securityusersid) {
            this.isAwaitingEdit = true;
        } else { this.isAwaitingEdit = false }

        if (data?.Action?.psychotropicid) {
            const { status } = data;
            const roleStatusMap: any = {
                'CWCW': [],
                'CWPSYPHARM': [],
                'CWPSYCOORD': [],
                'CWPSYPSYCH': [] as string[]
            };
            if (this.isAwaitingEdit === true) {
                roleStatusMap.CWPSYCOORD.push('Awaiting Assignment');
                roleStatusMap.CWPSYCOORD.push('Information Incomplete');
                roleStatusMap.CWPSYCOORD.push('Pending Peer To Peer Review');
                roleStatusMap.CWPSYPHARM.push('Pending Pharmacist Review');
                roleStatusMap.CWPSYPHARM.push('Information Incomplete');
                roleStatusMap.CWPSYPHARM.push('Pending Peer To Peer Review');
                roleStatusMap.CWPSYPSYCH.push('Pending CAP Review');
                roleStatusMap.CWPSYPSYCH.push('Information Incomplete');
                roleStatusMap.CWPSYPSYCH.push('Pending Peer To Peer Review');

            }
            if (roleStatusMap[this.toCheckCurentROle]?.includes(status)) {
                return false;
            } else {
                return true;
            }
        } else
            return true;
}
    }

    viewSSN(data: any,id: string,from: string = '') {
        let $currentSSN = $(`#${id}`);
        let $currentSSNViewIcon = $(`#${id}Icon`);
        if ($currentSSN.text().indexOf('**') > -1) {
            let ssn = data.ssn || data.ssnno;
            $currentSSNViewIcon.removeClass('fa-eye').addClass('fa-eye-slash');
            $currentSSN.text(this.formatToSSN(ssn));
        } else {
            $currentSSNViewIcon.removeClass('fa-eye-slash').addClass('fa-eye');
            if (from) {
                $currentSSN.text(data.dialogMaskedSSN);
            } else {
                $currentSSN.text(data.maskedSSN);
            }
        }

    }

    formatToSSN(ssn: string) {
        return `${ssn.slice(0,3)}-${ssn.slice(3,5)}-${ssn.slice(5)}`
    }

    handleActionRoute(event: any): void {
        const data = this.renameColumnName(event);
        this.actionRoute.emit(JSON.stringify(data));
    }

    isPaginationAvailable(): boolean {
        return this.totalpagecount > this.pageSize;
    }

    getCellStyle(key: string,data: any): any {
        if (this.columnStyleMap.includes(key)) {
            if (key === 'Task Status') {
                if (data[key] === 'Completed') {
                    return { color: 'green' };
                } else if (data[key] === 'Pending') {
                    return { color: 'red' };
                }
            }
            if (key === 'Due Date' || key === 'Due Status') {
                return this.getDueDateCellStyle(data);
            }
        }
    }

    getDueDateCellStyle(data: any) {
        let completiondate;
        if (data['Task Status'] === 'Completed') {
            let cdate = data['Due Status'];
            let duedate = data['Due Date'];
            const match = cdate.match(/\d{2}-\d{2}-\d{4}/);
            if (match) {
                completiondate = match[0];
            }
            const parsedCompletion = new Date(completiondate.replace(/-/g,'/'));
            const parsedDueDate = new Date(duedate.replace(/-/g,'/'));
            const isDueAfterCompletion = parsedDueDate >= parsedCompletion;
            if (isDueAfterCompletion) {
                return { color: 'green' };
            } else {
                return { color: 'red' };
            }
        } else if (data['Task Status'] === 'Pending') {
            return { color: 'red' };
        }
    }
    
    searchClosure(client: any, programType: string): void {
        const data = {
            clientData : client,
            programTypeData : programType
        }

        this.searchClosureData.emit(JSON.stringify(data));
      }
    
      sendforApproval(inputData: any): void {
        const data = {
            data : inputData,
            isSend : false
        }
        this.CaseClosureApproveAction.emit(JSON.stringify(data));
        
      }

      searchFoster(item: any) {
        this.searchFosterData.emit(JSON.stringify(item));
      }

      searchGap(client_id: any,removal_id: any) {
        const item = {
            clientid : client_id,
            removalid : removal_id,
        }
        this.searchGapData.emit(JSON.stringify(item));
      }

      searchAdoption(client_id: any, removal_id: any, sqnm_sw: any) {
        const item = {
            clientid : client_id,
            removalid : removal_id,
            sqnmsw : sqnm_sw
        }
        this.searchAdoptionData.emit(JSON.stringify(item));
      }

      searchACA(item: any) {
        this.searchACAData.emit(JSON.stringify(item));
      }

      IVEActionMethodCall(type: any, data: any, sqnm_sw? : any) {
        const item = {
            type : type,
            data : data,
            sqnm_sw : sqnm_sw
        }
        this.IVEActionMethods.emit(JSON.stringify(item));
      }

      confirmClosure(item: any) : void {
        this.closureApprovalConfirm.emit(JSON.stringify(item));
      }

    shouldShowAssignButton(status: string): boolean {
        const statusCheck: any = ['Approved', 'Rejected', 'Returned to Worker'].includes(status);
        return !statusCheck;
    }

    shouldShowAssignMeButtonToCW(data: any): boolean {
        const status: any = data['status'] ?? data['Current Status'];
        let statusCheck: boolean = ['Returned to Worker'].includes(status);
        const checkname = this.currentuser?.user?.securityusersid === data.Action.edituser;
        return !checkname && statusCheck;
    }

    open(popupId: string, selectedData: any) {
        this.customEvent.emit({
            id: popupId,
            selectedData
        });
    }

   
   toggleTable(id: any,data:any) {
    (<any>$('#' + id)).collapse('toggle');
    if(this.showrefilldata == id){
    this.collapsebtn = !this.collapsebtn
    }
else{
    this.showrefilldata = id;
    this.collapsebtn = true;
   
   
    if(this.collapsebtn){
        this.rindex =id;
          this.getrefilldata(data);
  }
  else{
     this.rindex ='';
     this.refilldata=[];
  }
}

}

  getrefilldata(data:any){


     this.refilldata=[];
     this.refilldata = this.tableData.filter((x:any)=>(x.Action.renewal ==true 
          
          && x.Action.personmedicpshychotropicparentid === data.personmedicpshychotropicid
          
         
      ))
      
  }
  checkforrefill(data:any){
this.refilldata=[];
this.refilldata = this.tableData.filter((x:any)=>(x.Action.renewal ==true 
          
          && x.Action.personmedicpshychotropicparentid === data.Action.personmedicpshychotropicid
       
    ))
   
if(this.refilldata.length > 0){
return true;
}
else{
    return false;
}
}
}
