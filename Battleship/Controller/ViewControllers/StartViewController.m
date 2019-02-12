//
//  StartViewController.m
//  Battleship
//
//  Created by doxper on 26/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "StartViewController.h"
#import "CreateBoardViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

#pragma mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark Action Methods
- (IBAction)playButtonClicked:(UIButton *)sender {
    [self navigateToCreateBoardViewController];
}

#pragma mark Private Methods
-(void)navigateToCreateBoardViewController {
    CreateBoardViewController *createBoardViewController = (CreateBoardViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateBoardViewController"];
    [self.navigationController pushViewController:createBoardViewController animated:YES];
}
@end
