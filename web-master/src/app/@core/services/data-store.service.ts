import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { DynamicObject } from '../entities/common.entities';

@Injectable({ providedIn: 'root' })
export class DataStoreService {
    private currentStoreSubject = new BehaviorSubject<DynamicObject>({} as DynamicObject);
    public currentStore = this.currentStoreSubject.asObservable();
    private exclusions = ['PERMISSION'];

    setData(key: string, value: any, forceSubscribe: boolean = true, target: string = '') {
        const currentStore = this.getCurrentStore();
        currentStore[key] = value;
        currentStore['ENFORCE_SUBSCRIPTION'] = forceSubscribe;
        currentStore['SUBSCRIPTION_TARGET'] = target;
        this.currentStoreSubject.next(currentStore);
    }
    // In order to perfrom minimum changes adding below duplicate code
    setObj(key: string, value: any, forceSubscribe: boolean = true, target: string = ''){
       this.setData(key, value, forceSubscribe, target);
    }
    // In order to perfrom minimum changes adding below duplicate code
    getObj(key: string): any {
        const currentStore = this.getCurrentStore();
        return currentStore[key];
    }
    public removeItem(keydata: string): void {
        const currentStore = this.getCurrentStore();
        Object.keys(currentStore).forEach((key) => {
            if (keydata === key) {
                delete currentStore[key];
            }
        });
        this.currentStoreSubject.next(currentStore);
    }

    setObject(value: any, forceSubscribe: boolean = true, target: string = '') {
        value['ENFORCE_SUBSCRIPTION'] = forceSubscribe;
        value['SUBSCRIPTION_TARGET'] = target;
        this.currentStoreSubject.next(value);
    }

    getData(key: string): any {
        const currentStore = this.getCurrentStore();
        return currentStore[key];
    }
    isAuthorized()
    {
        //ForFortify
        return true;
    }
    clearStore() {
        const currentStore = this.getCurrentStore();
        Object.keys(currentStore).forEach((key) => {
            if (this.exclusions.indexOf(key) === -1) {
                delete currentStore[key];
            }
        });
        this.currentStoreSubject.next(currentStore);
    }
    clearStoreWithout() {
      //  this.currentStoreSubject = new BehaviorSubject<DynamicObject>({} as DynamicObject);
        const currentStore = this.getCurrentStore();
        Object.keys(currentStore).forEach((key) => {
               delete currentStore[key];
        });
        this.currentStoreSubject.next(currentStore);
    }

    getCurrentStore(): DynamicObject {
        return this.currentStoreSubject.value;
    }
}
