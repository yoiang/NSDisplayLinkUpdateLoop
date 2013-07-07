//
//  NSDisplayLinkUpdateLoop.m
//  NSDisplayLinkUpdateLoopDemo
//
//  Created by Ian on 7/6/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "NSDisplayLinkUpdateLoop.h"

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NSDisplayLinkUpdateLoop()
{
    @private
    CADisplayLink* displayLink;
    NSTimeInterval lastUpdateTime;

    NSMutableArray* subscribers;
}

-( void )update;

@end

@implementation NSDisplayLinkUpdateLoop

-( id )init
{
    self = [ super init ];
    if ( self )
    {
        @synchronized( subscribers )
        {
            subscribers = [ [ NSMutableArray alloc ] init ];
        }
        displayLink = [ [ CADisplayLink displayLinkWithTarget:self selector:@selector( update ) ] retain ];
        [ displayLink addToRunLoop:[ NSRunLoop currentRunLoop ] forMode:NSDefaultRunLoopMode ];
        lastUpdateTime = [ [ NSDate date ] timeIntervalSinceReferenceDate ];
    }
    
    return self;
}

-( void )dealloc
{
    [ subscribers release ];
    [ super dealloc ];
}

// TODO: path through subscribe and unsubscribe to reduce blocking
-( void )subscribe:( id< NSDisplayLinkUpdateLoopDelegate > )delegate
{
    @synchronized( subscribers )
    {
        if ( ![ subscribers containsObject:delegate ] )
        {
            [ subscribers addObject:delegate ];
        }
    }
}

-( void )unsubscribe:( id< NSDisplayLinkUpdateLoopDelegate > )delegate
{
    @synchronized( subscribers )
    {
        [ subscribers removeObject: delegate ];
    }
}

-( void )update
{
    NSTimeInterval currentUpdateTime = [ [ NSDate date ] timeIntervalSinceReferenceDate ];
    NSTimeInterval deltaTime = currentUpdateTime - lastUpdateTime;
    lastUpdateTime = currentUpdateTime;
    
    @synchronized( subscribers )
    {
        for (id< NSDisplayLinkUpdateLoopDelegate >delegate in subscribers )
        {
            [ delegate update:deltaTime ];
        }
    }
}
@end
