import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ResourcesSetupTreeComponent } from './resources-setup-tree.component';

describe('ResourcesSetupTreeComponent', () => {
  let component: ResourcesSetupTreeComponent;
  let fixture: ComponentFixture<ResourcesSetupTreeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ResourcesSetupTreeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ResourcesSetupTreeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
