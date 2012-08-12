//
//  iLohRUAppDelegate.m
//  iLohRU
//
//  Created by Ryzhkov Mihailo on 23.07.10.
//  Copyright n/a 2010. All rights reserved.
//

#import "iLohRUAppDelegate.h"
#import "iLohRUViewController.h"
#import "Client.h"

@implementation iLohRUAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize twitArray;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	
	NSMutableArray *tempArraysi = [[NSMutableArray alloc] init];
	self.twitArray = tempArraysi;
	[tempArraysi release];
	[self addToTwitList];
    // Add the view controller's view to the window and display.
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (BOOL)isAvailable:(NSString *)urls
{
	
    NSString *stringURL = [NSString stringWithFormat:urls, @"test"];
    NSURL *url = [NSURL URLWithString:stringURL];
    return [[UIApplication sharedApplication] canOpenURL:url];
}

-(void)addToTwitList {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Clients" ofType:@"plist"];
	
    NSArray *clients = [NSArray arrayWithContentsOfFile:path];
	//NSString *name;
	//NSString *template;
	for (NSDictionary *dict in clients)
    {
		// name = [dict objectForKey:@"name"];
		//template = [dict objectForKey:@"template"];
		//cliObj.names = name;
		//cliObj.url = template;
		Client *cliObj = [[[Client alloc] initWithPrimaryKey:0] autorelease];
		cliObj.names = [dict objectForKey:@"name"];
		cliObj.url = [dict objectForKey:@"template"];
		
		if ([self isAvailable:cliObj.url]) {
			//NSLog(@"%@", cliObj.names);
			[twitArray addObject:cliObj];
			
		}
		
		
		
    }
	//NSLog(@"%d", [twitArray count]);
}

- (void)dealloc {
	[twitArray release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
