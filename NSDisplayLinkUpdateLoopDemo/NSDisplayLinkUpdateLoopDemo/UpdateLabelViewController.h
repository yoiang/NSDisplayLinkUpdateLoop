//
//  UpdateLabelViewController.h
//  NSDisplayLinkUpdateLoopDemo
//
//  Created by Ian on 7/6/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "NSDisplayLinkUpdateLoop.h"

@interface UpdateLabelViewController : UIViewController< NSDisplayLinkUpdateLoopDelegate >
{
}

@property( assign, getter = updateLoop, setter = setUpdateLoop: ) NSDisplayLinkUpdateLoop* updateLoop;
@property( readwrite ) unsigned int updateFrameCount;

-( void )addDeltaTime:( NSTimeInterval )deltaTime;

@end
