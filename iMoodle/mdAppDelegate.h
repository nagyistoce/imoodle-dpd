//
//  mdAppDelegate.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDViewController;

@interface MDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MDViewController *viewController;

@end
