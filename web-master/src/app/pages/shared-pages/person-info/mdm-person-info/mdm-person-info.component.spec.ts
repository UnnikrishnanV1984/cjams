import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MdmPersonInfoComponent } from './mdm-person-info.component';

describe('MdmPersonInfoComponent', () => {
  let component: MdmPersonInfoComponent;
  let fixture: ComponentFixture<MdmPersonInfoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MdmPersonInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MdmPersonInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
