#NSDisplayLinkUpdateLoop

NSDisplayLinkUpdateLoop is a simple object providing notification from your application whenever the screen is updated.

This simplifies building your own update loops, provides a higher level of precision than an NSTimer and allows syncronization with screen updates ([aside](http://fabiensanglard.net/doomIphone/index.php): a neat read by Fabien Sanglard about an issue with NSTimer and his alternative workaround).

To use NSDisplayLinkUpdateLoop first have your object inherit and implement the NSDisplayLinkUpdateLoopDelegate interface

	#include "NSDisplayLinkUpdateLoop.h"

	@interface IWannaUpdate : NSObject< NSDisplayLinkUpdateLoopDelegate >
  ...

	@implementation IWannaUpdate
	-( void )update:( NSTimeInterval )deltaTime
	{
    ...
	}

Next instantiate an NSDisplayLinkUpdateLoop and have your object subscribe

	-( void )startUpdates
	{
		IWannaUpdate* updateMe = [ [ IWannaUpdate alloc ] init ];

		updateLoop = [ [ NSDisplayLinkUpdateLoop alloc ] init ];
    [ updateLoop start ];

    [ updateLoop subscribe:updateMe ];
	}

To stop receiving update calls

	[ updateLoop unsubscribe:updateMe ];

To properly release your NSDisplayLinkUpdateLoop be sure to stop it first

	[ updateLoop stop ];

Easy!

##Note
NSDisplayLinkUpdateLoop retains its subscribers, make sure you understand when you're creating a reference ownership loop!
