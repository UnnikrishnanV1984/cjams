
import {map} from 'rxjs/operators';
import { Injectable } from '@angular/core';
import { DropdownModel } from '../entities/common.entities';
import { Observable } from 'rxjs';
import moment from 'moment';
import { CommonUrlConfig } from '../common/URLs/common-url.config';
import { CommonHttpService } from './common-http.service';
import { NewUrlConfig } from '../../pages/newintake/newintake-url.config';
import { AuthService } from './auth.service';
import { DataStoreService } from './data-store.service';
import { CASE_STORE_CONSTANTS } from '../../pages/case-worker/_entities/caseworker.data.constants';


@Injectable({ providedIn: 'root' })
export class CommonDropdownsService {
   referencetypeurl = 'referencetype/gettypes?filter';
   referencevalueurl = 'referencevalues?filter';


  _personRelations: any;
  constructor(private dropdownService: CommonHttpService, private authService: AuthService,
    private _dataStoreService: DataStoreService) { }

  getGenders(): Observable<any[]> {
    return this.dropdownService
      .create({
        where: { activeflag: 1 },
        method: 'post',
        nolimit: true
      },
        CommonUrlConfig.EndPoint.Listing.GenderTypeUrl + '/genderlist').pipe(map(res => {

          return res;
        }
        ));
  }

  getEtinicity(): Observable<any[]> {
    return this.dropdownService
      .getArrayList({
        where: { activeflag: 1 },
        method: 'get',
        nolimit: true
      },
        CommonUrlConfig.EndPoint.Listing.EthnicGroupTypeUrl + '?filter').pipe(map(res => {

          return res;
        }
        ));
  }

  getStateList(): Observable<any[]> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Listing.StateListUrl + '?filter'
    );
  }

  getNationalOriginList(): Observable<any[]> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        order: 'description'
      },
      CommonUrlConfig.EndPoint.Listing.NationalOriginList
    );
  }

  getCountyList(state: string): Observable<any[]> {
    return this.dropdownService.create(
      {
        where: { state: state },
        order: 'countyname',
        method: 'post',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Listing.CountyListUrl
      );
  }

  getRelations(): Observable<any[]> {
    return this.dropdownService.getArrayList({
        where: { activeflag: 1, teamtypekey: 'CW' },
        method: 'get',
        nolimit: true,
        order: 'description'
      },
      NewUrlConfig.EndPoint.Intake.RelationshipTypesUrl + '?filter'
    );
  }

  getReligions(): Observable<any[]> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        order: 'typedescription'
      },
      CommonUrlConfig.EndPoint.Intake.ReligionTypeUrl + '?filter'
    );
  }

  getRaces(): Observable<any[]> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        activeflag: 1,
        order: 'typedescription'
      },
      CommonUrlConfig.EndPoint.Intake.RaceTypeUrl + '?filter'
    );
  }

  getMaritalStatus(): Observable<any[]> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        order: 'typedescription'
      },
      CommonUrlConfig.EndPoint.Intake.MaritalStatusUrl + '?filter'
    );
  }

  getAlertType(): Observable<any[]> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true
      },
      NewUrlConfig.EndPoint.Intake.AlertType + '?filter'
    );
  }

  getFolderTypes(): Observable<any[]> {
    return this.dropdownService
      .getArrayList(
        {}, CommonUrlConfig.EndPoint.Intake.folderTypeList
      ).pipe(
      map(result => {
        return result.map(
          res =>
            new DropdownModel({
              text: res.description,
              value: res.foldertypekey
            })
        );
      }));
  }

  getAddressType(): Observable<any> {
    return this.dropdownService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        order: 'typedescription'
      }, CommonUrlConfig.EndPoint.Intake.AddressTypeUrl);
  }

  getFrequencyDetails(): Observable<any> {
    return this.dropdownService.getArrayList({
      method: 'get'
    }, CommonUrlConfig.EndPoint.Intake.substanceAbuseFrequencyList);
  }

  get personRelations() {
    return this._personRelations;
  }

  set personRelations(personRelations) {
    this._personRelations = personRelations;
  }

  getDropownsByTable(tableName: any, teamTypeKey: any = '') {
    const teamTypKeyVal = (teamTypeKey) ? teamTypeKey : this.authService.getAgencyName();
    return this.dropdownService.getArrayList({
      method: 'get',
      where: { tablename: tableName, teamtypekey: teamTypKeyVal }
    }, this.referencetypeurl);
  }

  getCommunicationTypes() {
    return this.dropdownService.getArrayList({
    }, CommonUrlConfig.EndPoint.Intake.IntakeServiceRequestInputTypeUrl);
  }

  getListByTableID(tableId: any) {
    return this.dropdownService.getArrayList(
      {
        where: { referencetypeid: tableId, teamtypekey: this.authService.getAgencyName(), order: 'description asc' },
        method: 'get'
      },
      this.referencetypeurl
    );
  }

  getListAllByTableID(tableId: any) {
    return this.dropdownService.getArrayList(
      {
        where: { referencetypeid: tableId, teamtypekey: this.authService.getAgencyName(), order: 'description asc' },
        method: 'get'
      },
      'referencetype/allvaluesbyreferenceid?filter'
    );
  }

  getValidDate(givenDate: string) {
    if (givenDate) {
      const processedDate = moment(givenDate);
      return processedDate.toDate();
    } else {
      return null;
    }
  }

  getPickListByName(tableName: any, teamtypekey?: any, displayorder?: any) {

    return this.dropdownService.getArrayList({
      method: 'get',
      where: { tablename: tableName, teamtypekey: teamtypekey },
      order: displayorder ? displayorder : false
    }, this.referencetypeurl);
  }

  getPickList(picklistid: any) {
    return this.dropdownService.getArrayList({
      where: {
        'picklist_type_id': picklistid
      },
      nolimit: true,
      method: 'get'
    }, 'tb_picklist_values/getpicklist?filter');
  }

  getPickListByMdmcode(code: any) {

    return this.dropdownService.getArrayList({
      method: 'get',
      nolimit: true,
      order: 'description',
      where: { referencetypeid: 306, activeflag: 1, mdmcode: (code ? {"like":code + "~%25","options":"i" } : null)}
    }, this.referencevalueurl);
  }

  getStoredCaseUuid() {
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (caseID) {
      return caseID;
    }
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseUUID = null;
    if (caseInfo) {
      caseUUID = caseInfo.intakeserviceid;
    }
    return caseUUID;
  }

  getStoredCaseNumber() {
    const daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    if (daNumber) {
      return daNumber;
    }
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let ldaNumber = null;
    if (caseInfo) {
      ldaNumber = caseInfo.da_number;
    }
    return ldaNumber;
  }

  formatPhoneNumber(phoneNumberString: string) {
    if (!phoneNumberString) {
      return null;
    }
    const cleaned = ('' + phoneNumberString).replace(/\D/g, '');
    const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
      return '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return null;
  }

  /**
   * This gets reference values using the type id directly
   * Preference shound be to use the getReferenveValuesByTypeName
   * @param typeid the reference type id
   */
  getReferenveValuesByTypeId(typeid: any) {
    return this.dropdownService.getArrayList(
      {
        nolimit: true,
        where: { referencetypeid: typeid},
        method: 'get'
      },
      this.referencevalueurl
    );
  }

  /**
   * This gets reference values using the type id and teamtypekey
   * @param typeid the reference type id
   * @param teamtypekey the reference team type key
   */
  getReferenveValuesByTypeIdandTeam(typeid: any, teamkey: any) {
    return this.dropdownService.getArrayList(
      {
        nolimit: true,
        where: { referencetypeid: typeid, teamtypekey: teamkey},
        method: 'get'
      },
      this.referencevalueurl
    );
  }

  /**
   *
   * @param tableName The reference type name is called 'tablename' in referencetype table
   */
  getReferenveValuesByTypeName(typename: any) {
    return this.dropdownService.getArrayList({
      method: 'get',
      where: { tablename: typename, teamtypekey: null }
    },
    this.referencetypeurl);
  }

}
