//
//  mdAppDelegate.m
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mdAppDelegate.h"

#import "mdViewController.h"
#import <RestKit/RestKit.h>
#import "mdCourse.h"
#import "mdUser.h"

@implementation mdAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)mapCourse
{
    RKObjectMapping* restKitObjectMapping = [RKObjectMapping mappingForClass:[mdCourse class]];
	[restKitObjectMapping mapKeyPath:@"id" toAttribute:@"id"];
	[restKitObjectMapping mapKeyPath:@"shortname" toAttribute:@"shortname"];
	[restKitObjectMapping mapKeyPath:@"categoryid" toAttribute:@"categoryid"];
	[restKitObjectMapping mapKeyPath:@"categorysortorder" toAttribute:@"categorysortorder"];
	[restKitObjectMapping mapKeyPath:@"fullname" toAttribute:@"fullname"];
	[restKitObjectMapping mapKeyPath:@"idnumber" toAttribute:@"idnumber"];
	[restKitObjectMapping mapKeyPath:@"summary" toAttribute:@"summary"];
	[restKitObjectMapping mapKeyPath:@"summaryformat" toAttribute:@"summaryformat"];
	[restKitObjectMapping mapKeyPath:@"format" toAttribute:@"format"];
	[restKitObjectMapping mapKeyPath:@"showgrades" toAttribute:@"showgrades"];
	[restKitObjectMapping mapKeyPath:@"newsitems" toAttribute:@"newsitems"];
	[restKitObjectMapping mapKeyPath:@"numsections" toAttribute:@"numsections"];
	[restKitObjectMapping mapKeyPath:@"maxbytes" toAttribute:@"maxbytes"];
	[restKitObjectMapping mapKeyPath:@"visible" toAttribute:@"visible"];
	[restKitObjectMapping mapKeyPath:@"hiddensections" toAttribute:@"hiddensections"];
	[restKitObjectMapping mapKeyPath:@"groupmodeforce" toAttribute:@"groupmodeforce"];
	[restKitObjectMapping mapKeyPath:@"defaultgroupingid" toAttribute:@"defaultgroupingid"];
	[restKitObjectMapping mapKeyPath:@"timecreated" toAttribute:@"timecreated"];
	[restKitObjectMapping mapKeyPath:@"timemodified" toAttribute:@"timemodified"];
	[restKitObjectMapping mapKeyPath:@"enablecompletion" toAttribute:@"enablecompletion"];
	[restKitObjectMapping mapKeyPath:@"completionstartonenrol" toAttribute:@"completionstartonenrol"];
	[restKitObjectMapping mapKeyPath:@"completionnotify" toAttribute:@"completionnotify"];
	[restKitObjectMapping mapKeyPath:@"lang" toAttribute:@"lang"];
	RKObjectManager* restKitObjectManager = [RKObjectManager objectManagerWithBaseURL:@"http://moodle.openfmi.net"];
	restKitObjectManager.acceptMIMEType = RKMIMETypeXML;
	[restKitObjectManager.mappingProvider setMapping:restKitObjectMapping forKeyPath:@""];
}

-(void)mapUser
{
    RKObjectMapping* restKitObjectMapping = [RKObjectMapping mappingForClass:[mdUser class]];
	[restKitObjectMapping mapKeyPath:@"courseid" toAttribute:@"courseid"];
	[restKitObjectMapping mapKeyPath:@"userid" toAttribute:@"userid"];
	[restKitObjectMapping mapKeyPath:@"firstname" toAttribute:@"firstname"];
	[restKitObjectMapping mapKeyPath:@"lastname" toAttribute:@"lastname"];
	[restKitObjectMapping mapKeyPath:@"fullname" toAttribute:@"fullname"];
	[restKitObjectMapping mapKeyPath:@"username" toAttribute:@"username"];
	[restKitObjectMapping mapKeyPath:@"profileimgurl" toAttribute:@"profileimgurl"];
	[restKitObjectMapping mapKeyPath:@"profileimgurlsmall" toAttribute:@"profileimgurlsmall"];
	RKObjectManager* restKitObjectManager = [RKObjectManager objectManagerWithBaseURL:@"http://moodle.openfmi.net/"];
	[restKitObjectManager.mappingProvider setMapping:restKitObjectMapping forKeyPath:@"user"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self mapCourse];
	[self mapUser];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[mdViewController alloc] initWithNibName:@"mdViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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
