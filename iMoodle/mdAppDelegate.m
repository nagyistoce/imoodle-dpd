//
//  mdAppDelegate.m
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDCoursesViewController.h"
#import "MDLoginViewController.h"
#import <RestKit/RestKit.h>
#import "MDToken.h"
#import "MDCourse.h"
#import "MDUser.h"

@implementation MDAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)map
{
	RKObjectManager* restKitObjectManager = [RKObjectManager objectManagerWithBaseURL:@"http://moodle.openfmi.net"];
	
	RKObjectMapping* tokenObjectMapping = [RKObjectMapping mappingForClass:[MDToken class]];
	tokenObjectMapping.rootKeyPath = @"";
	[tokenObjectMapping mapKeyPathsToAttributes:@"token", @"token", nil];
	[restKitObjectManager.mappingProvider setMapping:tokenObjectMapping forKeyPath:@"token"];
	
    RKObjectMapping* courseObjectMapping = [RKObjectMapping mappingForClass:[MDCourse class]];
	courseObjectMapping.rootKeyPath = @"RESPONSE.MULTIPLE.SINGLE";
	[courseObjectMapping mapKeyPathsToAttributes:
		@"id", @"id", 
		@"shortname", @"shortName",
		@"categoryid", @"categoryID",
		@"categorysortorder", @"categorySortOrder",
		@"fullname", @"fullName",
		@"idnumber", @"IDNumber",
		@"summary", @"summary",
		@"summaryformat", @"summaryFormat",
		@"format", @"format",
		@"showgrades", @"showGrades",
		@"newsitems", @"newsItems",
		@"numsections", @"numberOfSections",
		@"maxbytes", @"maxBytes",
		@"visible", @"visible",
		@"hiddensections", @"hiddenSections",
		@"groupmodeforce", @"groupModeForce",
		@"defaultgroupingid", @"defaultGroupingID",
		@"timecreated", @"timeCreated",
		@"timemodified", @"timeModified",
		@"enablecompletion", @"enableCompletion",
		@"completionstartonenrol", @"completionStartOnEnrol",
		@"completionnotify", @"completionNotify",
		@"lang", @"language", nil];
	[restKitObjectManager.mappingProvider setMapping:courseObjectMapping forKeyPath:@"course"];
	
    RKObjectMapping* userObjectMapping = [RKObjectMapping mappingForClass:[MDUser class]];
	userObjectMapping.rootKeyPath = @"RESPONSE.MULTIPLE.SINGLE";
	[userObjectMapping mapKeyPathsToAttributes:
		@"courseid", @"courseid",
		@"userid", @"userid",
		@"firstname", @"firstname",
		@"lastname", @"lastname",
		@"fullname", @"fullname",
		@"username", @"username",
		@"profileimgurl", @"profileimgurl",
		@"profileimgurlsmall", @"profileimgurlsmall", nil];
	[restKitObjectManager.mappingProvider setMapping:userObjectMapping forKeyPath:@"user"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self map];
    [RKClient sharedClient].requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
	[RKClient sharedClient].disableCertificateValidation = YES;
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	UINavigationController* navigationController = [[UINavigationController alloc] initWithNibName:@"MDNavigationController" bundle:nil];
	self.window.rootViewController = self.viewController = navigationController;
    [self.window makeKeyAndVisible];
	MDLoginViewController* loginViewController = [[MDLoginViewController alloc] initWithNibName:@"MDLoginViewController" bundle:nil];
//	MDCoursesViewController* loginViewController = [[MDCoursesViewController alloc] initWithNibName:@"MDCoursesViewController" bundle:nil];
	[navigationController pushViewController:loginViewController animated:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

@end
