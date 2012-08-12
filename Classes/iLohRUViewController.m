//
//  iLohRUViewController.m
//  iLohRU
//
//  Created by Ryzhkov Mihailo on 23.07.10.
//  Copyright n/a 2010. All rights reserved.
//

#import "iLohRUAppDelegate.h"
#import "iLohRUViewController.h"
#import "Client.h"

@implementation iLohRUViewController

@synthesize ifupdate,url,outs,go;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(IBAction)goThis:(id)sender {
	[url resignFirstResponder];
	[outs resignFirstResponder];
	[self getLohShorter];
}

-(IBAction)twit:(id)sender {
	
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Выбрать твиттер клиент"
													   delegate:self
											  cancelButtonTitle:@"Закрыть"
										 destructiveButtonTitle:nil
											  otherButtonTitles:nil];
	
	//Client *client = [appDelegate.twitArray init];
	//Client *myObj = [appDelegate.twitArray objectAtIndex:0];
	////NSLog(@"%@", myObj.names);
	sheet.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	
	for (Client *client in appDelegate.twitArray)
	{
		[sheet addButtonWithTitle:client.names];
	}
	//[sheet addButtonWithTitle:@"Закрыть"];
	[sheet showInView:self.view];
	[sheet release];
}
-(void)getLohShorter
{

	spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(147.0, 246.0, 20.0, 20.0)];
	[spinningWheel startAnimating];
	spinningWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[[self view] addSubview:spinningWheel];
	

	NSArray *Items = [url.text componentsSeparatedByString:@"//"];
	NSString *response = [Items lastObject];
	
	NSLog(@"%@", response);

	if ([response isEqualToString:@""]) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Ошипка?Хде ошипко?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	
	NSString *urlString = [NSString stringWithFormat:@"http://loh.ru/shorten?url=%@",url.text];
	NSLog(@"%@", urlString);
	NSURL *urls = [NSURL URLWithString:urlString];
	
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: urls];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection release];
	[request release];
	NSLog(@"sent");
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSDictionary *results = [jsonString JSONValue];

	NSString *endAll = [results objectForKey:@"shortUrl"];
	if ([endAll isEqualToString:@"Bad url"]) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Ну и что ты неверно ввел?Лох..." message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	outs.text = endAll;
	ifupdate.text = @"Скопировано в Pasteboard/Copied to Pasteboard";

	UIPasteboard *pb = [UIPasteboard generalPasteboard];
	[pb setString:endAll];

	NSLog(@"didReceiveData %@ ", endAll );
	[spinningWheel stopAnimating];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)data 
{

		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Интернета нету начальнега" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
		[alert show];

	[spinningWheel stopAnimating];
}
// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView {
	/*
	[self setView:[[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease]];
	[[self view] setBackgroundColor:[UIColor whiteColor]];
	[[self view] setUserInteractionEnabled:YES];
	
	
	
	go = [[UIButton alloc] initWithFrame:CGRectMake(53, 212, 214, 36)];   
	[go addTarget:self action:@selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];    
	[[self view] addSubview:go]; */
//}


- (void)buttonPressed:(UIButton *)button
{
	if (button == go)
		NSLog(@"test");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	//We resign the first responder
	//This closes the keyboard
	NSLog(@"close");
	[textField resignFirstResponder];
	
	//Do what ever other fanciness you want
	//TODO: fanciness
	
	//Return YES to confirm the UITextField is returning
	return YES;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	appDelegate = (iLohRUAppDelegate *)[[UIApplication sharedApplication] delegate];
	UIPasteboard *pb = [UIPasteboard generalPasteboard]; 
	url.text = [pb string];

	[url setAutocorrectionType:UITextAutocorrectionTypeNo];
    [super viewDidLoad];
}

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
NSString *buttonTitle = [modalView buttonTitleAtIndex:buttonIndex];
		for (Client *client in appDelegate.twitArray)
		{
			
			
			if ([buttonTitle isEqualToString:client.names]) {
				
				NSString *text = [NSString stringWithFormat:@"<your tweet> %@ #lohRu",outs.text];
				NSString *message = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, 
																						(CFStringRef)text,
																						NULL, 
																						(CFStringRef)@";/?:@&=+$,", 
																						kCFStringEncodingUTF8);
				
				NSString *stringURL = [NSString stringWithFormat:client.url, message];
				[message release];
				NSURL *urlss = [NSURL URLWithString:stringURL];
				[[UIApplication sharedApplication] openURL:urlss]; 
				
			}
		}

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[ifupdate release];
	[spinningWheel release];
	[url release];
	[outs release];
	[go release];
    [super dealloc];
}

@end
