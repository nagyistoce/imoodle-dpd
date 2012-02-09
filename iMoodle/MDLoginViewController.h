//
//  MDLoginViewController.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 09.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface MDLoginViewController : UIViewController<RKObjectLoaderDelegate>
{
	NSString* _token;
}

@property (strong, nonatomic) IBOutlet UITextField* textFieldUserName;
@property (strong, nonatomic) IBOutlet UITextField* textFieldPassword;
- (IBAction)buttonLoginTouchDown:(id)sender;

@end
