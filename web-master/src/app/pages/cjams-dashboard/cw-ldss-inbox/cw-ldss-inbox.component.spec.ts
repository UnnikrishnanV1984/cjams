import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwLdssInboxComponent } from './cw-ldss-inbox.component';

describe('CwLdssInboxComponent', () => {
  let component: CwLdssInboxComponent;
  let fixture: ComponentFixture<CwLdssInboxComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwLdssInboxComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwLdssInboxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
