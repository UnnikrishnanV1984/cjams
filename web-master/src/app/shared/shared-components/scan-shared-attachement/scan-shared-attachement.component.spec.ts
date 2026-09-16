import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ScanSharedAttachementComponent } from './scan-shared-attachement.component';

describe('ScanSharedAttachementComponent', () => {
  let component: ScanSharedAttachementComponent;
  let fixture: ComponentFixture<ScanSharedAttachementComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ScanSharedAttachementComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ScanSharedAttachementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
