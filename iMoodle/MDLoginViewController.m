//
//  MDLoginViewController.m
//  iMoodle
//
//  Created by Dimitar Dobrev on 09.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDLoginViewController.h"
#import "MDCoursesViewController.h"
#import <RestKit/RestKit.h>
#import "MDToken.h"
#import "MDUser.h"

@implementation MDLoginViewController
@synthesize textFieldUserName;
@synthesize textFieldPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
	{
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTextFieldUserName:nil];
    [self setTextFieldPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonLoginTouchDown:(id)sender 
{
	RKObjectManager* restKitObjectManager = [RKObjectManager sharedManager];
	restKitObjectManager.client.baseURL = @"https://moodle.openfmi.net";
	NSString* resourcePath = @"/login/token.php?username=%@&password=%@&service=moodle_mobile_app";
	NSString* url = [NSString stringWithFormat:resourcePath, textFieldUserName.text, textFieldPassword.text];
	[restKitObjectManager loadObjectsAtResourcePath:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] delegate:self
						  block:^(RKObjectLoader* loader) 
						  {
							  loader.objectMapping = [restKitObjectManager.mappingProvider objectMappingForClass:[MDToken class]];
						  }];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)loader willMapData:(inout id*)mappableData
{
	NSDictionary* single = [[*mappableData valueForKey:@"RESPONSE"] valueForKey:@"SINGLE"];
	for (NSDictionary* keyValuePair in [single valueForKey:@"KEY"])
	{
		[single setValue:[keyValuePair valueForKey:@"VALUE"] forKey:[keyValuePair valueForKey:@"name"]];
	}
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects 
{
	if (objects.count == 0)
	{
		return;
	}
	id object = [objects objectAtIndex:0];
	if ([object isKindOfClass:[MDToken class]])
	{
		MDToken* token = object;
		_token = token.token;
		RKObjectManager* restKitObjectManager = [RKObjectManager sharedManager];
		restKitObjectManager.client.baseURL = @"https://moodle.openfmi.net";
		NSString* resourcePath = @"/webservice/rest/server.php?wstoken=%@&wsfunction=moodle_webservice_get_siteinfo";
		[restKitObjectManager loadObjectsAtResourcePath:[NSString stringWithFormat:resourcePath, _token] delegate:self
							  block:^(RKObjectLoader* loader) 
							  {
								  loader.objectMapping = [restKitObjectManager.mappingProvider objectMappingForClass:[MDUser class]];
								  loader.objectMapping.rootKeyPath = @"RESPONSE.SINGLE";
							  }];
	}
	else
	{
		objectLoader.objectMapping.rootKeyPath = @"RESPONSE.MULTIPLE.SINGLE";
		MDUser* user = object;
		MDCoursesViewController* coursesViewController = [[MDCoursesViewController alloc] initWithNibName:@"MDCoursesViewController" bundle:nil];
		coursesViewController.token = _token;
		coursesViewController.userID = user.userid;
		[self.navigationController pushViewController:coursesViewController animated:YES];
	}
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error 
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to Moodle." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

@end
