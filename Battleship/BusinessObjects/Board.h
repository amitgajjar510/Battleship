//
//  Board.h
//  Battleship
//
//  Created by doxper on 30/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ship.h"

@interface Board : NSObject

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSMutableArray *blocks;
@property (nonatomic, strong) NSArray *ships;

-(instancetype)initWithTag:(NSInteger)tag;

-(void)moveShip:(Ship*)ship toBlockNumber:(NSInteger)blockNumber;
-(BOOL)allShipsFound;

@end
