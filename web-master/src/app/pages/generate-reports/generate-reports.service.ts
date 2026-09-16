import { Injectable } from '@angular/core';
import { CommonHttpService, AuthService } from '../../@core/services';
import { CommonUrlConfig } from '../../@core/common/URLs/common-url.config';
import { HttpClient } from '@angular/common/http';
import { AppConfig } from '../../app.config';
import { AppUser } from '../../@core/entities/authDataModel';

@Injectable()
export class GenerateReportsService {
  baseUrl: string;
  user: AppUser;

  roleKeyMap :any= {
    RTCD: 93,
    apcs: 133
  };
  roleURLMap :any= {
    RTCD: CommonUrlConfig.EndPoint.RESTITUTION.REPORTS,
    apcs: CommonUrlConfig.EndPoint.REPORTS.SUPERVISOR
  };
  constructor(
    private _httpService: CommonHttpService,
    private http: HttpClient,
    private _authService: AuthService
  ) {
    this.baseUrl = AppConfig.baseUrl;
    this.user = this._authService.getCurrentUser();
  }

  listDocument(documentType: string, condition: any) {
    return this._httpService.getPagedArrayList(condition, this.roleURLMap[this.user.role.name].LISTING + documentType + '?filter');
  }

  generateDocument(documentType: string, condition:any) {
    this._httpService.download(this.roleURLMap[this.user.role.name].GENERATE + documentType, condition).subscribe(res => {
      const blob = new Blob([new Uint8Array(res)]);
      const link = document.createElement('a');
      link.href = window.URL.createObjectURL(blob);
      link.download = `${condition.where.outputfilename}.${condition.where.type}`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  }
}
