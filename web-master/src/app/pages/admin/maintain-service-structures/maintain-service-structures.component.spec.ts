import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MaintainServiceStructuresComponent } from './maintain-service-structures.component';

describe('MaintainServiceStructuresComponent', () => {
  let component: MaintainServiceStructuresComponent;
  let fixture: ComponentFixture<MaintainServiceStructuresComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MaintainServiceStructuresComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MaintainServiceStructuresComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
