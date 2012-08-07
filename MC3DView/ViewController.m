//
//  ViewController.m
//  MC3DView
//
//  Created by Baglan on 8/7/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "ViewController.h"
#import "MC3DBoxView.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MC3DBoxView *boxView = [[MC3DBoxView alloc] initWithFrame:self.view.bounds
                                                     sideSize:self.view.frame.size
                                                     distance:-500];
    [self.view addSubview:boxView];
    
    UIColor *bg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"checkers"]];
    
    boxView.frontView.backgroundColor = bg;
    boxView.rightView.backgroundColor = bg;
    boxView.backView.backgroundColor = bg;
    boxView.leftView.backgroundColor = bg;
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [boxView.frontView addSubview:mapView];
    mapView.layer.rasterizationScale = 2.0;
    mapView.layer.shouldRasterize = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
