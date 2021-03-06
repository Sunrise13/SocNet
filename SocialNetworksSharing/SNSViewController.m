//
//  SNSViewController.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "SNSViewController.h"
#import "SNSNetworksViewController.h"
#import "SNSPostData.h"

@interface SNSViewController ()


@end

@implementation SNSViewController

//Enter your text here

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SNSPostData sharedPostData];//maybe it's not needed
}


- (IBAction)cameraPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uppload the photo" message:nil delegate:self cancelButtonTitle:@"Dissmiss" otherButtonTitles:@"Take the photo",@"Choose existing",nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2 /*Use existing*/)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
    }
}



- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_shareImage setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Button"])
    {
        SNSNetworksViewController * dController = segue.destinationViewController;
        dController.mainController = self;
    }
    
    
    if (![self.shareText.text isEqual:@""])
    {
        [[SNSPostData sharedPostData] setWithText:self.shareText.text];
    }
    if ((_shareImage.image.size.height>1)&&(_shareImage.image.size.width>1))
    {
        [[SNSPostData sharedPostData] setWithImage:self.shareImage.image];
    }
    else
    {
        [[SNSPostData sharedPostData] setWithImage:[UIImage imageNamed:@"default.jpg"]];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"View appeared %@" ,self);
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"View will appear %@", self);
}
-(void) viewWillDisappear:(BOOL)animated
{
    NSLog(@" %@View will disapper",self);
}

@end
