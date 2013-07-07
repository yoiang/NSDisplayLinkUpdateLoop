//
//  ViewController.h
//  NSDisplayLinkUpdateLoopDemo
//
//  Created by Ian on 7/6/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSDisplayLinkUpdateLoop.h"

@class UpdateLabelViewController;

@interface ViewController : UIViewController< NSDisplayLinkUpdateLoopDelegate >
{
    IBOutlet UpdateLabelViewController* line1;
    IBOutlet UpdateLabelViewController* line2;
    IBOutlet UpdateLabelViewController* line3;
    IBOutlet UpdateLabelViewController* line4;
}

@property(nonatomic, retain) UpdateLabelViewController* line1;
@property(nonatomic, retain) UpdateLabelViewController* line2;
@property(nonatomic, retain) UpdateLabelViewController* line3;
@property(nonatomic, retain) UpdateLabelViewController* line4;

@end
