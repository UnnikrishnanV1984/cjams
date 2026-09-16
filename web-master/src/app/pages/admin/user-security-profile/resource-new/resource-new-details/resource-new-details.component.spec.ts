import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ResourceNewDetailsComponent } from './resource-new-details.component';

describe('ResourceNewDetailsComponent', () => {
  let component: ResourceNewDetailsComponent;
  let fixture: ComponentFixture<ResourceNewDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ResourceNewDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ResourceNewDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
