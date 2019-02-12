//
//  GameViewController.h
//  Battleship
//
//  Created by doxper on 30/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardController.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) BoardController *boardController;

@end
