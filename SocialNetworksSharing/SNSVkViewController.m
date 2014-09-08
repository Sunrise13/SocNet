//
//  SNSVkViewController.m
//  SocialNetworksSharing
//
//  Created by Sasha Gypsy on 06.09.14.
//  Copyright (c) 2014 Sasha Gypsy. All rights reserved.
//

#import "SNSVkViewController.h"
#import "SNSVkontakte.h"

@interface SNSVkViewController () <UIWebViewDelegate>

@property (copy, nonatomic) LoginCompletionBlock completionBlock;
@end

@implementation SNSVkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithBlock:(LoginCompletionBlock) completionBlock {
    
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    if ([self.authView.request.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound) {
//        self.authView.hidden = YES;
////        NSString *secret = [self.authView.request.URL.absoluteString getStringBetweenString:@"access_token" andString:@"&"]; //извлекаем из ответа token
//        NSLog(@"%@", secret); //печатаем secret в консоль
//    } else if ([self.authView.request.URL.absoluteString rangeOfString:@"error"].location != NSNotFound) {
//        self.authView.hidden = YES;
//        NSLog(@"%@", self.authView.request.URL.absoluteString); //выводим ошибку
//    } else {
//        self.authView.hidden = NO; //показываем окно авторизации
//    }
//}


//-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    //https://api.vk.com/method/'''METHOD_NAME'''?'''PARAMETERS'''&access_token='''ACCESS_TOKEN'''
//    
//    
//    if ([[[request URL] host] isEqualToString:@"hello.there"])
//    {
//        NSLog(@"%@", request);
////        SLVVkToken* token = [[SLVVkToken alloc] init];
//        
//        NSString* query = [[request URL] description];
//        
//        NSArray* array = [query componentsSeparatedByString:@"#"];
//        
//        if ([array count] > 1) {
//            query = [array lastObject];
//        }
//        
//        NSArray* pairs = [query componentsSeparatedByString:@"&"];
//        
//        for (NSString* pair in pairs) {
//            
//            NSArray* values = [pair componentsSeparatedByString:@"="];
//            
//            if ([values count] == 2) {
//                
//                NSString* key = [values firstObject];
//                
//                if ([key isEqualToString:@"access_token"]) {
//                    token.token = [values lastObject];
//                } else if ([key isEqualToString:@"expires_in"]) {
//                    
//                    NSTimeInterval interval = [[values lastObject] doubleValue];
//                    
//                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
//                    
//                } else if ([key isEqualToString:@"user_id"]) {
//                    
//                    token.userID = [values lastObject];
//                }
//            }
//        }
//        
//        self.authView.delegate = nil;
//        
//        
//        //[self postToVk];
//        //[self publishVK];
//        
//        if (self.completionBlock) {
//            self.completionBlock(token);
//        }
//        
//        
//        [self dismissViewControllerAnimated:YES
//                                 completion:nil];
//        
//        return NO;
//    }
//    return YES;
//}


@end
