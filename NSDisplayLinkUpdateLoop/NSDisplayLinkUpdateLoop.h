//
//  NSDisplayLinkUpdateLoop.h
//  NSDisplayLinkUpdateLoopDemo
//
//  Created by Ian on 7/6/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSDisplayLinkUpdateLoopDelegate;

@interface NSDisplayLinkUpdateLoop : NSObject

-( void )subscribe:( id< NSDisplayLinkUpdateLoopDelegate > )delegate;
-( void )unsubscribe:( id< NSDisplayLinkUpdateLoopDelegate > )delegate;

-( void )start;
-( void )stop;

@end

@protocol NSDisplayLinkUpdateLoopDelegate <NSObject>
@required
-( void )update:( NSTimeInterval )deltaTime;

@end
