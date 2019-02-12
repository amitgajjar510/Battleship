//
//  Ship.h
//  Battleship
//
//  Created by doxper on 26/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Carrier,
    Battleship,
    Submarine,
    Cruiser,
    Patrol
} ShipType;

@interface Ship : NSObject

@property (nonatomic, assign) ShipType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger totalBlocks;
@property (nonatomic, strong) NSMutableArray *assignedBlocks;
@property (nonatomic, assign) BOOL isHorizontal;
@property (nonatomic, strong) UIColor *color;

-(instancetype)initWithShipType:(ShipType)type;

-(BOOL)found;

@end
