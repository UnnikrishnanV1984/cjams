import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ListlivingArrangementComponent } from './list-living-arrangement.component';

describe('ListAddressComponent', () => {
  let component: ListlivingArrangementComponent;
  let fixture: ComponentFixture<ListlivingArrangementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ListlivingArrangementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListlivingArrangementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
