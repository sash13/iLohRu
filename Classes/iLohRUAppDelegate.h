//
//  iLohRUAppDelegate.h
//  iLohRU
//
//  Created by Ryzhkov Mihailo on 23.07.10.
//  Copyright n/a 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Client;
@class iLohRUViewController;

@interface iLohRUAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iLohRUViewController *viewController;
	NSMutableArray *twitArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iLohRUViewController *viewController;
@property (nonatomic, retain) NSMutableArray *twitArray;

- (BOOL)isAvailable:(NSString *)urls;
- (void) addToTwitList;

@end

