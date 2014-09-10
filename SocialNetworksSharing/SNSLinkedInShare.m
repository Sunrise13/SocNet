//
//  SNSLinkedInShare.m
//  SocialNetworksSharing
//
//  Created by Ostap R on 10.09.14.
//  Copyright (c) 2014 Ostap R. All rights reserved.
//

#import <REComposeViewController.h>
#import "SNSLinkedInShare.h"
#import "SLVLinkedInApi.h"
#import "SNSPostData.h"

@interface SNSLinkedInShare ()

@property(nonatomic) REComposeViewController * shareViewController;

@end

@implementation SNSLinkedInShare

#pragma mark - SNSSocialNetwork Protocol

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
            
            if (result == REComposeResultCancelled)
            {
                NSLog(@"Cancelled");
                // Make here dismiss
            }
            
            if (result == REComposeResultPosted)
            {
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
