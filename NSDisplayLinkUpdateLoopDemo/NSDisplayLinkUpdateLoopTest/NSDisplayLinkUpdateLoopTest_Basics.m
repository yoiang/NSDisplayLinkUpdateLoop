//
//  NSDisplayLinkUpdateLoopTest.m
//  NSDisplayLinkUpdateLoopTest
//
//  Created by Ian on 7/7/13.
//  Copyright (c) 2013 Adorkable. All rights reserved.
//

#import "NSDisplayLinkUpdateLoop.h"

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

SpecBegin( NSDisplayLinkUpdateLoop_Basics )

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

SpecEnd
