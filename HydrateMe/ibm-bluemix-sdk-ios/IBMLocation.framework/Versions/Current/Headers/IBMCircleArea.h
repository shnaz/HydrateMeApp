//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMCircleArea.h
//  IBMLocation iOS SDK

#import "IBMArea.h"
@class IBMPosition;
@class IBMPoint;
@protocol IBMAreaVisitor;

/**
 A circle, defined by its center point and a radius that can be used to define an IBMGeoAreaTrigger or IBMGeoDwellTrigger.
 
 The objects in this class are immutable
 
 The IBMCircleArea class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMCircleArea : NSObject <IBMArea>

/**
 The radius of the circle in meters
 */
@property (readonly) double radius;
/**
 The center position of the circle
 */
@property (readonly) IBMPosition *center;

/**
 A construtor to create a new circle
 
 @param center The circle's center
 @param radius The circle's radius (in meters)
 */
- (id)initWithCenterPosition:(IBMPosition*)center radius:(double)radius;

@end

