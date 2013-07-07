//
//  NSDisplayLinkUpdateLoopTest.m
//  NSDisplayLinkUpdateLoopTest
//
//  Created by Ian on 7/7/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "NSDisplayLinkUpdateLoop.h"

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "OCMock.h"

SpecBegin( NSDisplayLinkUpdateLoop )

describe( @"Lifetime", ^{
    __block NSDisplayLinkUpdateLoop* displayLink;
    
    beforeEach(^{
        displayLink = [ [ NSDisplayLinkUpdateLoop alloc ] init ];
    });
    
    it(@"init", ^{
        expect( displayLink ).notTo.equal( nil );
        expect( [ displayLink self ] ).notTo.equal( nil );
    });
    
    afterEach(^{
        [ displayLink release ];
    });
});

describe( @"Ownership", ^{
    __block NSDisplayLinkUpdateLoop* displayLink;
    
    beforeEach(^{
        displayLink = [ [ NSDisplayLinkUpdateLoop alloc ] init ];
    });
    
    it(@"init", ^{
        expect( [ displayLink retainCount ] == 1 );
    });
    
    it(@"start", ^{
        [ displayLink start ];
        expect( [ displayLink retainCount ] > 1 );
        [ displayLink stop ];
    });
    
    it(@"stop", ^{
        [ displayLink start ];
        [ displayLink stop ];
        expect( [ displayLink retainCount ] == 1 );
    });
    
    afterEach(^{
        [ displayLink release ];
    });
});

// TODO: test for existance of race conditions (there shouldn't be any!)
describe( @"Subscription", ^{
    __block NSDisplayLinkUpdateLoop* displayLink;
    __block id delegate;
    __block NSUInteger updateCallCount;
    
    beforeEach(^{
        displayLink = [ [ NSDisplayLinkUpdateLoop alloc ] init ];
        delegate = [ OCMockObject mockForProtocol:@protocol( NSDisplayLinkUpdateLoopDelegate ) ];
        updateCallCount = 0;
        
        void (^updateBlock)(NSInvocation *) = ^(NSInvocation *invocation)
        {
            updateCallCount ++;
        };
        [ [ [ [ delegate stub ] andDo:updateBlock] ignoringNonObjectArgs ] update:0 ];
        [ displayLink start ];
    });
    
    it(@"subscribed", ^{
        [ displayLink subscribe:delegate ];
        
        // these work because runUntilDate blocks
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.beGreaterThan( 0 );
    });
    
    it(@"unsubscribed", ^{
        // first subscribe and verify we've updated
        [ displayLink subscribe:delegate ];
        
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.beGreaterThan( 0 );
        
        // then unsubscribe and make sure we don't receive any more calls
        [ displayLink unsubscribe:delegate ];
        NSUInteger previousCallCount = updateCallCount;
        
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.equal( previousCallCount );
    });
    
    afterEach(^{
        [ displayLink stop ];
        [ displayLink release ];
    });
});

describe( @"StartAndStop", ^{
    __block NSDisplayLinkUpdateLoop* displayLink;
    __block id delegate;
    __block NSUInteger updateCallCount;
    
    beforeEach(^{
        displayLink = [ [ NSDisplayLinkUpdateLoop alloc ] init ];
        delegate = [ OCMockObject mockForProtocol:@protocol( NSDisplayLinkUpdateLoopDelegate ) ];
        updateCallCount = 0;
        
        void (^updateBlock)(NSInvocation *) = ^(NSInvocation *invocation)
        {
            updateCallCount ++;
        };
        [ [ [ [ delegate stub ] andDo:updateBlock] ignoringNonObjectArgs ] update:0 ];
    });
    
    it(@"start", ^{
        [ displayLink subscribe:delegate ];
        
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.equal( 0 );
        
        [ displayLink start ];
        
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.beGreaterThan( 0 );

        [ displayLink stop ];
    });
    
    it(@"stop", ^{
        [ displayLink subscribe:delegate ];
        [ displayLink start ];
        
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.beGreaterThan( 0 );
        
        [ displayLink stop ];
        NSUInteger previousCallCount = updateCallCount;
        
        [ [ NSRunLoop mainRunLoop ] runUntilDate:[ NSDate dateWithTimeIntervalSinceNow:0.5 ] ];
        
        expect( updateCallCount ).to.equal( previousCallCount );
    });
    
    afterEach(^{
        [ displayLink release ];
    });
});
 

SpecEnd
