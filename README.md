#NSDisplayLinkUpdateLoop

NSDisplayLinkUpdateLoop is a simple object providing notification from your application whenever the screen is updated.

This simplifies building your own update loops and provides a higher level of precision than an NSTimer ([aside](http://fabiensanglard.net/doomIphone/index.php): a neat read by Fabien Sanglard about an issue with NSTimer and his alternative workaround).

To use NSDisplayLinkUpdateLoop first have your object inherit and implement the NSDisplayLinkUpdateLoopDelegate interface

	#include "NSDisplayLinkUpdateLoop.h"

	@interface IWannaCelebrate : NSObject< NSDisplayLinkUpdateLoopDelegate >
	{

	}
	@end

	...

	@implementation IWannaCelebrate
	-( void )update:( NSTimeInterval )deltaTime
	{
		[ self oneMoreTime:deltaTime ];
	}

Next instantiate an NSDisplayLinkUpdateLoop and have your object subscribe

	-( void )startUpdates
	{
		IWannaCelebrate* celebration = [ [ IWannaCelebrate alloc ] init ];

		updateLoop = [ [ NSDisplayLinkUpdateLoop alloc ] init ];
    	*[ updateLoop subscribe:celebration ]*;	
	}

To stop receiving update calls

	*[ updateLoop unsubscribe:celebration ]*

Easy!

##Note
NSDisplayLinkUpdateLoop retains its subscribers, make sure you understand when you're creating a reference ownership loop!
