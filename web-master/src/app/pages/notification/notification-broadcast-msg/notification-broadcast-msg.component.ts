
import {pluck, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { BroadCastMessage } from '../_entities/notification-entity.module';
import { FormBuilder, Validators, FormGroup, FormControl } from '@angular/forms';
import { AlertService } from '../../../@core/services/alert.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'notification-broadcast-msg',
    templateUrl: './notification-broadcast-msg.component.html',
    styleUrls: ['./notification-broadcast-msg.component.scss'],
    standalone: false
})
export class NotificationBroadcastMsgComponent implements OnInit {
    paginationInfo: PaginationInfo = new PaginationInfo();
    broadCastMessage: BroadCastMessage[] = [];
    totalResulRecords$!: Observable<number>;
    selectUsers: any[] = [];
    isallusers = false;
    broadcastMessageForm!: FormGroup;
    announcement: Object = new Object();
    constructor(private _commonHttpService: CommonHttpService, private formBuilder: FormBuilder, private _alertService: AlertService) { }

    ngOnInit() {
        this.formInitilize();
        this.getUserList(1);
    }
    formInitilize() {
        this.broadcastMessageForm = this.formBuilder.group({
            details: ['', Validators.required]
        });
    }
    getUserList(pageNo: number) {
        this._commonHttpService.endpointUrl = 'users/list?filter';
        const body: PaginationRequest = {
            limit: 10,
            page: pageNo,
            method: 'get'
        };
        const source = this._commonHttpService.getPagedArrayList(body).pipe(pluck('data'));
        const count: Observable<number> = this._commonHttpService.getPagedArrayList(body).pipe(pluck('count'));
        if (this.isallusers === true) {
            source.pipe(map((data: BroadCastMessage[]) => {
                data.forEach(item => {
                    item.isSelected = true;
                });
                return data;
            })).subscribe(data => this.broadCastMessage = data);
        } else {
            source.pipe(map((data: BroadCastMessage[]) => {
                data.forEach(item => {
                    if (this.selectUsers.includes(item.id)) {
                        item.isSelected = true;
                    } else {
                        item.isSelected = false;
                    }
                });
                return data;
            })).subscribe(data => this.broadCastMessage = data);
        }
        if (pageNo === 1) {
            this.totalResulRecords$ = count;
        }
    }

    pageChanged(page: number) {
        this.paginationInfo.pageNumber = page;
        this.getUserList(page);
    }
    selectUsersList(event: any, model: BroadCastMessage, i: any) {
        if (event.target.checked) {

            if (this.selectUsers.includes(model.id)) {
                this.selectUsers.splice(this.selectUsers.indexOf(model.id), 1);

                this.broadCastMessage = this.broadCastMessage.map((data) => {
                    if (data.id === model.id) {
                        data.isSelected = false;
                    }
                    return data;
                });

            } else {
                this.selectUsers.push(model.id);
                this.broadCastMessage = this.broadCastMessage.map((data) => {
                    if (data.id === model.id) {
                        data.isSelected = true;
                    }
                    return data;
                });
            }
        }
    }
    addBroadCastMessage() {
        if (this.isallusers === false) {
            this.announcement = {
                details: this.broadcastMessageForm.value.details,
                user: this.selectUsers
            };
        } else {
            this.announcement = {
                details: this.broadcastMessageForm.value.details,
                isallusers: this.isallusers
            };
        }
        if (this.broadcastMessageForm.valid) {
            if (this.selectUsers.length === 0 && this.isallusers === false) {
                this._alertService.warn('Please select atleast one user');
            } else {
                this._commonHttpService.create(this.announcement, 'announcement/add').subscribe((result) => {
                    this._alertService.success('Message added successfully!');
                    this.broadcastMessageForm.reset();
                    this.isallusers = false;
                    this.getUserList(1);
                });
            }
        } else {
            this._alertService.warn('Please fill the mandatory fields.');
        }
    }
    
    selectAll() {
        if (this.isallusers === false) {
            this.broadCastMessage = this.broadCastMessage.map((data) => {
                data.isSelected = true;
                return data;
            });
            this.isallusers = true;
        } else {
            this.broadCastMessage = this.broadCastMessage.map((data) => {
                data.isSelected = false;
                return data;
            });
            this.isallusers = false;
        }
    }

    getControlByIndexFn(index: string): FormControl {
        return this.broadcastMessageForm.controls[index] as FormControl;
    }
}
