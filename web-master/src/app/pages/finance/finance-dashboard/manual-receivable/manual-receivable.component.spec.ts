import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ManualReceivableComponent } from './manual-receivable.component';

describe('ManualReceivableComponent', () => {
  let component: ManualReceivableComponent;
  let fixture: ComponentFixture<ManualReceivableComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ManualReceivableComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ManualReceivableComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
