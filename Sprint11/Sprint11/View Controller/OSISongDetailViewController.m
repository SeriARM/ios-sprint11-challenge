//
//  OSISongDetailViewController.m
//  Sprint11
//
//  Created by Sergey Osipyan on 3/1/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSISongDetailViewController.h"
#import "OSISongController.h"
#import "OSISong.h"

@interface OSISongDetailViewController ()
@property OSISong *song;
@property OSISongController *osiSOngController;

@property (weak, nonatomic) IBOutlet UILabel *songRating;
@property (weak, nonatomic) IBOutlet UITextField *songTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextView *textBodyTextView;
@property (weak, nonatomic) IBOutlet UINavigationItem *songNavigationItem;
- (IBAction)saveButton:(id)sender;
- (IBAction)stepperAction:(id)sender;
- (IBAction)searchButton:(id)sender;
@end

@implementation OSISongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end