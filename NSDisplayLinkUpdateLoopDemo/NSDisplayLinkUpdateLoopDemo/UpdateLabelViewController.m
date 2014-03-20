//
//  UpdateLabelViewController.m
//  NSDisplayLinkUpdateLoopDemo
//
//  Created by Ian on 7/6/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "UpdateLabelViewController.h"

@interface UpdateLabelViewController ()
{
    @private
    NSDisplayLinkUpdateLoop* privateUpdateLoop;
    
    NSTimeInterval timeSinceLastUpdate;
    unsigned int frameCount;
}
-( void )setLabelText:( NSString* )text;

@end

@implementation UpdateLabelViewController

@synthesize updateFrameCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [ self setLabelText:@"-" ];
    
    timeSinceLastUpdate = 0;
    frameCount = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-( void )addDeltaTime:( NSTimeInterval )deltaTime
{
    timeSinceLastUpdate += deltaTime;
    frameCount ++;
    if ( frameCount >= updateFrameCount )
    {
        [ self setLabelText:[ NSString stringWithFormat:@" Time between %d frames was %f ms", updateFrameCount, timeSinceLastUpdate ] ];

        frameCount = 0;
        timeSinceLastUpdate = 0;
    }
}

-( void )setLabelText:( NSString* )text
{
    if ( [ self.view isKindOfClass:[ UILabel class ] ] )
    {
        UILabel* label = ( UILabel* )self.view;
        [ label setText:text ];
    }
}

-( NSDisplayLinkUpdateLoop* )updateLoop
{
    return self.updateLoop;
}

-( void )setUpdateLoop:( NSDisplayLinkUpdateLoop* )updateLoop
{
    [ privateUpdateLoop unsubscribe:self ];
    
    privateUpdateLoop = updateLoop;
    [ privateUpdateLoop subscribe:self ];
}

-( void )update:( NSTimeInterval )deltaTime
{
    [ self addDeltaTime:deltaTime ];
}

@end
