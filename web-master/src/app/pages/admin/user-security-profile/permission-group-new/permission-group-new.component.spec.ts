import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PermissionGroupNewComponent } from './permission-group-new.component';

describe('PermissionGroupNewComponent', () => {
  let component: PermissionGroupNewComponent;
  let fixture: ComponentFixture<PermissionGroupNewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PermissionGroupNewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PermissionGroupNewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
