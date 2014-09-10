//
//  SNSLinkedInShare.m
//  SocialNetworksSharing
//
//  Created by Ostap R on 10.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import "SNSLinkedInShare.h"
#import <REComposeViewController.h>
#import "SLVLinkedInApi.h"
#import "SNSPostData.h"

@interface SNSLinkedInShare () 

@end

@implementation SNSLinkedInShare

-(void)share
{
    if(!_shareViewController)
    {
        self.shareViewController= [[REComposeViewController alloc] init];
        self.shareViewController.title = @"LinkedIn";
        self.shareViewController.hasAttachment = NO;
        self.shareViewController.placeholderText=@"Type text";
        self.shareViewController.completionHandler=^(REComposeViewController *composeViewController, REComposeResult result)
        {
            [composeViewController dismissViewControllerAnimated:YES completion:nil];
            
            if (result == REComposeResultCancelled) {
                NSLog(@"Cancelled");
            }
            
            if (result == REComposeResultPosted) {
                NSLog(@"Text: %@", composeViewController.text);
                [[SNSPostData sharedPostData] setPostText:composeViewController.text];
                SLVLinkedInApi * linkedInAPI=[SLVLinkedInApi new];
                [linkedInAPI settingDataSource:[SNSPostData sharedPostData]];
                [linkedInAPI share];
            }

        };
    }
    [self.shareViewController presentFromRootViewController];
    
}




@end
