//
//  mdUser.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 27.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDUser : NSObject

@property (nonatomic) int courseid;
@property (nonatomic) int userid;
@property (nonatomic, retain) NSString* firstname;
@property (nonatomic, retain) NSString* lastname;
@property (nonatomic, retain) NSString* fullname;
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* profileimgurl;
@property (nonatomic, retain) NSString* profileimgurlsmall;

@end
