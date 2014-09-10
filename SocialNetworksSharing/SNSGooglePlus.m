//
//  SNSGooglePlus.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 08.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSGooglePlus.h"
#import "SNSPostData.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>


//#define GOOGLE_PLUS_CLIEND_ID @"440607175691-4bhfdefg7sbkrrjk3mp9t5dc15upiet0.apps.googleusercontent.com"

@implementation SNSGooglePlus 

static NSString * const kClientId = @"24680690125-2oo1g3qilirpek47sjtm88jtc9g4qnht.apps.googleusercontent.com";


- (void)SignInButtonSimulated
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    self.signIN = signIn;
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    signIn.clientID = kClientId;
    signIn.delegate = self;
    [signIn authenticate];
}

- (void)didReceiveMemoryWarning
{
    [self didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        
    } else {
        NSLog(@"%@ %@",[GPPSignIn sharedInstance].userEmail, [GPPSignIn sharedInstance].userID);
        
        [self Share];
        self.authorised = TRUE;
    }
}

// Share Code
- (void) share {
    
    if(!self.authorised)
    {
        [self SignInButtonSimulated];
    }
    else
        [self Share];
}


// For Signout USe this code
- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}

// Disconnet User
- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        NSLog(@"Ok");
    }
}

-(void)Share
{
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    [GPPShare sharedInstance].delegate = self;
    [shareBuilder setPrefillText:[[SNSPostData sharedPostData] getText]];
    [shareBuilder attachImage:[[SNSPostData sharedPostData] getImage]];
    [shareBuilder open];
}

- (void)finishedSharing:(BOOL)shared;
{
    if(shared)
        [self.controller.mainController.navigationController popToRootViewControllerAnimated:YES];
}

@end
