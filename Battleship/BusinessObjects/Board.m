//
//  Board.m
//  Battleship
//
//  Created by doxper on 30/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "Board.h"
#import "Block.h"

#define SIZE 10

@implementation Board

#pragma mark Initilization Methods
-(instancetype)initWithTag:(NSInteger)tag {
    self = [super init];
    if (self) {
        self.tag = tag;
        [self initializeBlocks];
        [self initializeShips];
    }
    return self;
}

-(void)initializeBlocks {
    self.blocks = [[NSMutableArray alloc] init];
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            Block *block = [[Block alloc] init];
            block.tag = (i * 10) + j;
            [self.blocks addObject:block];
        }
    }
}

-(void)initializeShips {
    Ship *carrier = [[Ship alloc] initWithShipType:Carrier];
    [self moveShip:carrier toBlockNumber:0];
    Ship *battleShip = [[Ship alloc] initWithShipType:Battleship];
    [self moveShip:battleShip toBlockNumber:20];
    Ship *submarine = [[Ship alloc] initWithShipType:Submarine];
    [self moveShip:submarine toBlockNumber:40];
    Ship *cruiser = [[Ship alloc] initWithShipType:Cruiser];
    [self moveShip:cruiser toBlockNumber:60];
    Ship *patrol = [[Ship alloc] initWithShipType:Patrol];
    [self moveShip:patrol toBlockNumber:80];
    self.ships = [[NSArray alloc] initWithObjects:carrier, battleShip, submarine, cruiser, patrol, nil];
}

#pragma mark Public Methods
-(void)moveShip:(Ship*)ship toBlockNumber:(NSInteger)blockNumber {
    BOOL success = YES;
    if (ship.totalBlocks == 1) {
        Block *foundBlock = [self.blocks objectAtIndex:blockNumber];
        if (foundBlock && (foundBlock.ship == nil || foundBlock.ship.type == ship.type)) {
            for (Block *block in ship.assignedBlocks) {
                block.ship = nil;
            }
            [ship.assignedBlocks removeAllObjects];
            [ship.assignedBlocks addObject:foundBlock];
            foundBlock.ship = ship;
        }
        else {
            success = NO;
            NSLog(@"Unable to move block");
        }
    }
    else {
        Block *selectedBlock = [self.blocks objectAtIndex:blockNumber];
        BOOL isHorizontal = ship.isHorizontal;
        if (selectedBlock.ship != nil && selectedBlock.ship.type == ship.type) {
            isHorizontal = !isHorizontal;
        }
        NSInteger number = blockNumber;
        BOOL isShipFoundOnBlock = NO;
        NSMutableArray *foundBlocks = [[NSMutableArray alloc] init];
        if (isHorizontal) {
            for (int i = 0; i < ship.totalBlocks; i++) {
                Block *block = [self.blocks objectAtIndex:number];
                if (block && (block.ship == nil || block.ship.type == ship.type)) {
                    [foundBlocks addObject:block];
                    NSInteger numberMod = number % 10;
                    NSInteger newNumberMod = (number + 1) % 10;
                    if (newNumberMod < numberMod) {
                        number = blockNumber - (ship.totalBlocks - (i + 1));
                    }
                    else {
                        number = number + 1;
                    }
                }
                else {
                    isShipFoundOnBlock = YES;
                    break;
                }
            }
        }
        else {
            for (int i = 0; i < ship.totalBlocks; i++) {
                Block *block = [self.blocks objectAtIndex:number];
                if (block && (block.ship == nil || block.ship.type == ship.type)) {
                    [foundBlocks addObject:block];
                    number = number - 10;
                    if (number < 0) {
                        number = blockNumber + ((ship.totalBlocks - (i + 1)) * 10);
                    }
                }
                else {
                    isShipFoundOnBlock = YES;
                    break;
                }
            }
        }
        if (!isShipFoundOnBlock) {
            ship.isHorizontal = isHorizontal;
            [foundBlocks sortUsingComparator:^NSComparisonResult(Block *block1, Block *block2) {
                return ship.isHorizontal ? block1.tag < block2.tag : block1.tag > block2.tag;
            }];
            for (Block *block in ship.assignedBlocks) {
                block.ship = nil;
            }
            ship.assignedBlocks = foundBlocks;
            for (Block *block in foundBlocks) {
                block.ship = ship;
            }
        }
        else {
            success = NO;
            NSLog(@"Unable to move block");
        }
    }
    
    if (!success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unableToMoveBlock" object:nil];
    }
}

-(BOOL)allShipsFound {
    NSInteger numberOfShipsFound = 0;
    for (Ship *ship in self.ships) {
        if ([ship found]) {
            numberOfShipsFound++;
        }
    }
    return numberOfShipsFound == self.ships.count;
}
@end
