//
//  mdAppDelegate.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mdViewController;

@interface mdAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) mdViewController *viewController;

@end
