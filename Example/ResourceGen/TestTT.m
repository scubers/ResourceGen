//
//  TestTT.m
//  ResourceGen_Example
//
//  Created by Jrwong on 2019/7/25.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

#import "TestTT.h"
#import "ResourceGen_Example-Swift.h"
@import ResourceGen;

@implementation TestTT

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", [RM_OC font_primary].system);
        NSLog(@"%@", [RM_OC image_ic]);
        NSLog(@"%@", [RM_OC file_b_txt]);
    });
}

@end
