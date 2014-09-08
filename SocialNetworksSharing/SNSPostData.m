//
//  SNSPostData.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSPostData.h"
#import "SNSViewController.h"

@implementation SNSPostData

+ (id)sharedPostData
{
    static SNSPostData *postDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        postDataManager = [[self alloc] init];
    });
    return postDataManager;
}

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

-(void) setWithText:(NSString*) text
{
    if(self)
    {
        _postText = text;
    }
}

-(void) setWithImage:(UIImage*) image
{
    if(self)
    {
        _postImage = image;
    }
}

-(UIImage*) getImage
{
    return _postImage;
}

-(NSString*) getText
{
    return _postText;
}
-(NSString*)shareText
{
    if(self)
        return _postText;
    return nil;
}

-(UIImage *)shareImage
{
    if (self)
        return _postImage;
    return nil;
}

@end
