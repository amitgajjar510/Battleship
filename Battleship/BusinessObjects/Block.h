//
//  Block.h
//  Battleship
//
//  Created by doxper on 27/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ship.h"

@interface Block : NSObject

@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, assign) BOOL isClicked;
@property (nonatomic, assign) BOOL isHit;
@property (nonatomic, weak) Ship *ship;

-(void)clicked;

@end
