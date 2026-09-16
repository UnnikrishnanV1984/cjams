import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Observable } from 'rxjs';
import { CommonDropdownsService, AlertService, GenericService } from '../../../../../@core/services';
import { PersonInfoService } from '../../person-info.service';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
const ADD_TEXT = 'Add';
const UPDATE_TEXT = 'Update';
@Component({
    selector: 'person-also-known-as',
    templateUrl: './person-also-known-as.component.html',
    styleUrls: ['./person-also-known-as.component.scss'],
    standalone: false
})
export class PersonAlsoKnownAsComponent implements OnInit {

  @Input() aliasList:any=[];
  akaDropdownItems$!: Observable<any[]>;
  prefixDropdownItems$!: Observable<any[]>;
  suffixDropdownItems$!: Observable<any[]>;
  @Output() isChanged = new EventEmitter<any>();
  alias:any= {};
  actionText: string='';
  hasAlias :boolean= false;
  updateIndex: any=[];
  deleteId :any= null;
  deletepopupid:string = '#delete-popup';
  constructor(private _service: GenericService<any>,
              private _commonDropdownService: CommonDropdownsService,
              private _personInfoService: PersonInfoService,
              private _alertService: AlertService) { }

  ngOnInit() {

    this.akaDropdownItems$ = this._commonDropdownService.getPickListByName('akatype');
    this.prefixDropdownItems$ = this._commonDropdownService.getPickListByName('prefix');
    this.suffixDropdownItems$ = this._commonDropdownService.getPickListByName('suffix');
    this.resetAlias();
    this._personInfoService.personInfoListener$.subscribe(personInfo => {
      setTimeout(() => {
        if (this._personInfoService.personInfo) {
          this.processAlias();
        }
      }, 2000);

    });
    
  }

  processAlias() {
    if (this._personInfoService.aliasList && this._personInfoService.aliasList.length) {
      this.hasAlias = true;
      this.aliasList = this._personInfoService.aliasList;
    } else {
      this.hasAlias = false;
    }
  }

  resetAlias() {
    this.alias = {
      'aliasid': null,
      'firstname': null,
      'lastname': null,
      'middlename': null,
      'sfxname': null,
      'akatypetypekey': null,
      'prefixtypekey': null,
      'personid': this._personInfoService.getPersonId()
    };
    this.updateIndex = null;
    this.actionText = ADD_TEXT;
  }

  addAlias(action:any) {

    if (!this.alias['akatypetypekey'] || !this.alias['firstname']) {
       this._alertService.error('Please fill required fields');
       return;
    }

    if (action === 'Update' && this.updateIndex != null) {
      this._personInfoService.aliasList = this._personInfoService.aliasList.map((item:any, i:any) => {
        if ( i === this.updateIndex) {
          item =  Object.assign({}, this.alias);
        }
        return item;
      });
      this.aliasList = this._personInfoService.aliasList;
      this.resetAlias();
    } else {
      this._personInfoService.aliasList.push(JSON.parse(JSON.stringify(this.alias)));
      this.aliasList = this._personInfoService.aliasList;
      this.resetAlias();
    }
    this.isChanged.emit(true);
  }
  confirmDelete(index:any) {
    this.deleteId = index;
    (<any>$(this.deletepopupid)).modal('show');
  }
  approvedDelete() {
      this._service.patchWithoutid(this.aliasList[this.deleteId], CommonUrlConfig.EndPoint.PERSON.DeleteAliasName).subscribe((res:any) => {

        if (res.count) {
          this._alertService.success('Aliasname deleted successfully.');
        }
      });
      this.aliasList.splice(this.deleteId, 1);
      this.resetAlias();
      this.processAlias();
      this.isChanged.emit(true);
      (<any>$(this.deletepopupid)).modal('hide');

  }
  declineDelete() {

    this.deleteId = null;
    (<any>$(this.deletepopupid)).modal('hide');
  }
  editAlias(item:any, index:any) {
    this.updateIndex = index;
    this.alias = Object.assign({}, item);
    this.actionText = UPDATE_TEXT;
  }


}
