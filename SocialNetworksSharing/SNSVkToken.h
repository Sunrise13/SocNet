//
//  SNSVkToken.h
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSVkToken : NSObject
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate* expirationDate;
@property (strong, nonatomic) NSString* userID;
@end

