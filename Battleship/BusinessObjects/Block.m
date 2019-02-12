//
//  Block.m
//  Battleship
//
//  Created by doxper on 27/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "Block.h"

@implementation Block

#pragma mark Initialize Methods
-(instancetype)init {
    self = [super init];
    if (self) {
        self.isClicked = NO;
        self.isHit = NO;
    }
    return self;
}

#pragma mark Public Method
-(void)clicked {
    self.isClicked = YES;
    if (self.ship) {
        self.isHit = YES;
    }
}

@end
