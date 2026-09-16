import { Injectable } from '@angular/core';
import { GenericService } from '../../../@core/services';
import { Observable } from 'rxjs';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';

@Injectable()
export class PersonBasicDetailsService {
  constructor(private _service: GenericService<any>) { }

  addNickName(nickname: any): Observable<any> {
    return this._service.create(nickname, CommonUrlConfig.EndPoint.PERSON.AddNickname);
  }

  getNickNames(personid: any): Observable<any> {
    return this._service.getArrayList({
      method: 'get',
      where: {
        personid: personid
      }
    }, CommonUrlConfig.EndPoint.PERSON.NickNameList);
  }

  updateNickName(nickname: any): Observable<any> {
    return this._service.patchWithoutid(nickname, CommonUrlConfig.EndPoint.PERSON.UpdateNickName);
  }

  deleteNickName(nickname: any): Observable<any> {
    return this._service.patchWithoutid(nickname, CommonUrlConfig.EndPoint.PERSON.DeleteNickName);
  }

  addAliasName(aliasName: any): Observable<any> {
    return this._service.create(aliasName, CommonUrlConfig.EndPoint.PERSON.AddAliasName);
  }

  getAliasNames(personid: any): Observable<any> {
    return this._service.getArrayList({
      method: 'get',
      where: {
        personid: personid
      }
    }, CommonUrlConfig.EndPoint.PERSON.AliasNameList);
  }

  updateAliasName(aliasname: any): Observable<any> {
    return this._service.patchWithoutid(aliasname, CommonUrlConfig.EndPoint.PERSON.UpdateAliasName);
  }

  deleteAliasName(aliasname: any): Observable<any> {
    return this._service.patchWithoutid(aliasname, CommonUrlConfig.EndPoint.PERSON.DeleteAliasName);
  }

  updateBasicDetails(basicInfo: any): Observable<any> {
    return this._service.patchWithoutid(basicInfo, CommonUrlConfig.EndPoint.PERSON.UpdateBasicInfo);
  }

}
