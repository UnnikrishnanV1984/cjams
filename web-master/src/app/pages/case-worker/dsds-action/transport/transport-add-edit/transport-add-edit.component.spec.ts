import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TransportAddEditComponent } from './transport-add-edit.component';

describe('TransportAddEditComponent', () => {
  let component: TransportAddEditComponent;
  let fixture: ComponentFixture<TransportAddEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TransportAddEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TransportAddEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
