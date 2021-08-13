//
//  ViewController.m
//  test
//
//  Created by Kanstantsin Bucha on 4/24/20.
//  Copyright © 2020 Viber Media, Inc. All rights reserved.
//

#import "ViewController.h"
#import "IncomingTypes.h"
#import "test-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testWithType: TestTypeA];
    [self testWithType: TestTypeShouldBeA];
    // Do any additional setup after loading the view.
}


@end
