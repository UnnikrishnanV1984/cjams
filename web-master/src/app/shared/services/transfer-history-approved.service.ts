import { Injectable } from '@angular/core';
import { AuthService } from '../../@core/services/auth.service';
import { DataStoreService } from '../../@core/services/data-store.service';

@Injectable()
export class TransferHistoryApprovedService {
    transferHistoryApproved: any[] = [];
    countyId!: string;
    authorstatus!: string;
    userinfo: any = {};
    usercounty!: string; 

    constructor(public _authService: AuthService,private readonly _dataStoreService: DataStoreService) {
        
    }

    getUserInfo() {
        this.transferHistoryApproved = this._dataStoreService.getData('transferHistory');
        this.countyId = this._dataStoreService.getData('transferHistorycountyid');
        this.authorstatus = this._dataStoreService.getData('authorstatus');
        this.userinfo = this._authService.getCurrentUser();
        this.usercounty = this.userinfo.user.userprofile.teammemberassignment.teammember.team.countyid; 
    }
    
    getTrasferHistory() {
        this.getUserInfo();
        if(this.transferHistoryApproved && this.transferHistoryApproved.length > 0) {
            if(this.usercounty !== this.countyId || (this.usercounty === this.countyId && (!this.authorstatus && this.userinfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey == 'CWSP'))) {
                return true;
            }
        } else {
            if(this.countyId && (this.usercounty !== this.countyId)) {
                return true;
            }
        }
    } 

    getTrasferHistoryDisposition() {
        this.getUserInfo();
        if(this.transferHistoryApproved && this.transferHistoryApproved.length > 0) {
            if(this.usercounty !== this.countyId) {
                return true;
            } else if(this.usercounty === this.countyId && (!this.authorstatus && this.userinfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey == 'CWSP')) {
                return false;
            }
        } else {
            if(this.usercounty !== this.countyId) {
                return true;
            }
        }
    }

}