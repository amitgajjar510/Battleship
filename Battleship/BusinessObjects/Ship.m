//
//  Ship.m
//  Battleship
//
//  Created by doxper on 26/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "Ship.h"
#import "Block.h"

@implementation Ship

#pragma mark initilaize Methods
-(instancetype)initWithShipType:(ShipType)type {
    self = [super init];
    if (self) {
        self.type = type;
        self.isHorizontal = YES;
        self.assignedBlocks = [[NSMutableArray alloc] init];
        [self initializeShipWithType:type];
    }
    return self;
}

-(void)initializeShipWithType:(ShipType)type {
    switch (type) {
        case Carrier:
            self.name = @"Carrier";
            self.totalBlocks = 5;
            self.color = [UIColor redColor];
            break;
        case Battleship:
            self.name = @"Battleship";
            self.totalBlocks = 4;
            self.color = [UIColor yellowColor];
            break;
        case Submarine:
            self.name = @"Submarine";
            self.totalBlocks = 3;
            self.color = [UIColor blueColor];
            break;
        case Cruiser:
            self.name = @"Cruiser";
            self.totalBlocks = 2;
            self.color = [UIColor greenColor];
            break;
        case Patrol:
            self.name = @"Patrol";
            self.totalBlocks = 1;
            self.color = [UIColor cyanColor];
            break;
        default:
            break;
    }
}

-(BOOL)found {
    NSInteger totalAssignedBlockHit = 0;
    for (Block *assignedBlock in self.assignedBlocks) {
        if (assignedBlock.isHit) {
            totalAssignedBlockHit++;
        }
    }
    return totalAssignedBlockHit == self.assignedBlocks.count;
}

@end
