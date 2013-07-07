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

    updateLines = [ [ NSArray arrayWithObjects:line1, line2, line3, line4, nil ] retain ];
    
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
    
    [ setUpdateLoop release ];
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
    [ updateLoop release ];

    [ updateLines release ];
    
    [ super dealloc ];
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
