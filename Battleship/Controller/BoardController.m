//
//  BoardController.m
//  Battleship
//
//  Created by doxper on 27/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "BoardController.h"

@implementation BoardController

#pragma mark Initialize Methods
-(instancetype)init {
    self = [super init];
    if (self) {
        [self initializeBoard];
    }
    return self;
}

#pragma mark Private Methods
-(void)initializeBoard {
    Board *playerOneBoard = [[Board alloc] initWithTag:0];
    Board *playerTwoBoard = [[Board alloc] initWithTag:1];
    self.boards = [[NSMutableArray alloc] initWithObjects:playerOneBoard, playerTwoBoard, nil];
}

@end
