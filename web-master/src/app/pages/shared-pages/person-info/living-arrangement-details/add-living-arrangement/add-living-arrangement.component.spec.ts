import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AddLivingArrangementComponent } from './add-living-arrangement.component';

describe('AddAddressComponent', () => {
  let component: AddLivingArrangementComponent;
  let fixture: ComponentFixture<AddLivingArrangementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AddLivingArrangementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddLivingArrangementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
