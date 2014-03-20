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
    BOOL started;
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
        started = NO;
        displayLink = [ CADisplayLink displayLinkWithTarget:self selector:@selector( update ) ];
        @synchronized( subscribers )
        {
            subscribers = [ [ NSMutableArray alloc ] init ];
        }
    }
    
    return self;
}

-( void )start
{
    if ( !started )
    {
        started = YES;
        [ displayLink addToRunLoop:[ NSRunLoop currentRunLoop ] forMode:NSDefaultRunLoopMode ];
        lastUpdateTime = [ [ NSDate date ] timeIntervalSinceReferenceDate ];
    }
}

-( void )stop
{
    if ( started )
    {
        started = NO;
        [ displayLink removeFromRunLoop:[ NSRunLoop currentRunLoop ] forMode:NSDefaultRunLoopMode ];
    }
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
    if ( started )
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
    } else
    {
        NSLog( @"Error: NSDisplayLinkUpdateLoop::update called before ::start" );
    }
}
@end
