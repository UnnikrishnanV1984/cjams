import { Injectable } from '@angular/core';

export class StorageService {
  tabKey!: string | null;
  exludeList = ['token', 'fbToken', 'activeModuleAgency','activeModuleNav','userProfile', 'selectedModuleRole','activeModuleRole','dynamsoftProductKey', 'IS_EXPUNGED_USER' ];
    constructor(protected Storage: any) {
  }

  public setTabKeyKey(key: string | null){
      this.tabKey = key;
  }

  public getItem(key: string): any {
    let data = this.Storage.getItem(this.tabKey + '.' + key);
    if (!data) {
      data = this.Storage.getItem(key);
    }
    return data;
  }

  public setItem(key: string, item: any): void {
    if ( this.exludeList.includes(key)) {
      return this.Storage.setItem(key, item);
    } else {
      return this.Storage.setItem(this.tabKey ? this.tabKey + '.' + key : key, item);
    }
  }

  public setItemKey(key: string, item: any): void {
    return this.Storage.setItem(key, item);
  }


  public getObj(key: string, safe = true): any {
    try {
      const item = this.getItem(key);
      return JSON.parse(item);
    } catch (e) {
      if (!safe) {
        throw (e);
      }
    }
  }

  public setObj(key: string, item: any): void {
    return this.setItem(key, JSON.stringify(item));
  }

  public removeItem(key: string): void {
    this.Storage.removeItem(this.tabKey + '.' + key);
    this.Storage.removeItem(key);
  }

  public removeItemWithOutTab(key: string): void {
    this.Storage.removeItem(key);
  }

  public setItemWithOutTab(key: string,item:any): void {
    this.Storage.setItem(key,item);
  }
  
  
  public clear(): void {
    this.Storage.clear();
  }

  public getCurrentSessionStorage(){
    return this.Storage;
  }
}

@Injectable({ providedIn: 'root' })
export class LocalStorageService extends StorageService {
  constructor() {
    super(window.localStorage);
  }
}

@Injectable({ providedIn: 'root' })
export class SessionStorageService extends StorageService {
  constructor() {
    super(window.sessionStorage);
  }
}
