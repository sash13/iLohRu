//
//  iLohRUViewController.h
//  iLohRU
//
//  Created by Ryzhkov Mihailo on 23.07.10.
//  Copyright n/a 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"

@class Client;

@interface iLohRUViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>{

	IBOutlet UITextField *url;
	IBOutlet UITextField *outs;
	IBOutlet UILabel *ifupdate;
	IBOutlet UIButton *go;
	UIActivityIndicatorView *spinningWheel;
	NSArray *_clients;
	iLohRUAppDelegate *appDelegate;

}

-(IBAction)goThis:(id)sender;
-(IBAction)twit:(id)sender;
-(void)getLohShorter;
@property (nonatomic, retain) IBOutlet UITextField *url;
@property (nonatomic, retain) IBOutlet UITextField *outs;
@property (nonatomic, retain) IBOutlet UILabel *ifupdate;
@property (nonatomic, retain) IBOutlet UIButton *go;


@end

