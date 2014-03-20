//
//  ViewController.m
//  NSDisplayLinkUpdateLoopDemo
//
//  Created by Ian on 7/6/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "ViewController.h"

#include "UpdateLabelViewController.h"

@interface ViewController ()
{
    NSDisplayLinkUpdateLoop* updateLoop;
    
    NSArray* updateLines;
}

-( void )setupForIndividualUpdate;
-( void )setupForMainViewControllerUpdate;

@end

@implementation ViewController

@synthesize line1, line2, line3, line4;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    updateLines = @[line1, line2, line3, line4];
    
//    [ self setupForMainViewControllerUpdate ];
    [ self setupForIndividualUpdate ];
}

-( void )setupForIndividualUpdate
{
    NSDisplayLinkUpdateLoop* setUpdateLoop = [ [ NSDisplayLinkUpdateLoop alloc  ] init ];
    [ setUpdateLoop start ];
    
    for (UpdateLabelViewController* labelController in updateLines)
    {
        [ labelController setUpdateLoop:setUpdateLoop ];
    }
}

-( void )setupForMainViewControllerUpdate
{
    updateLoop = [ [ NSDisplayLinkUpdateLoop alloc ] init ];

    [ updateLoop start ];
    [ updateLoop subscribe:self ];
}

-( void )dealloc
{
    [ updateLoop unsubscribe:self ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-( void )update:( NSTimeInterval )deltaTime
{
    for ( UpdateLabelViewController* labelController in updateLines )
    {
        [ labelController addDeltaTime:deltaTime ];
    }
}

@end
