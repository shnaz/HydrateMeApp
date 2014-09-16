//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoUtils.h
//  IBMLocation iOS SDK

#import "IBMConfidenceLevel.h"
@class IBMPosition;
@class IBMPolygon;
@protocol IBMArea;

/**
 Provides access to utility functions for Geo calculations.
 
 The IBMGeoUtils class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMGeoUtils : NSObject 

/**
 Calculates the distance between two coordinates.
 
 The distance between two coordinates is calculated. The result is returned in meters, using a spherical model of the Earth.
 
 @param coordinate1 The first coordinate.
 @param coordinate2 The second coordinate.
 @return The distance in meters between the two coordinates.
 */
+ (double)getDistanceFromCoordinate:(IBMPosition*)coordinate1 toCoordinate:(IBMPosition*)coordinate2;
/**
 Calculates the distance of the coordinate from the circle. Equivalent to calling getDistanceFromCoordinate:toCircleWithCenter:radius:withBufferZoneWidth: with a `0` as the `bufferZoneWidth` parameter.
 
 @param coordinate The starting coordinate
 @param center The center used to define the circle
 @param radius The radius used to define the circle
 @return (double) the distance in meters to the circle. The distance is positive for coordinates outside the circle and negative for coordinates inside the circle.
 */
+ (double)getDistanceFromCoordinate:(IBMPosition *)coordinate toCircleWithCenter:(IBMPosition *)center radius:(double)radius;
/**
 Calculates the distance of the coordinate from the circle, taking into account the buffer zone.
 
 @param coordinate The starting coordinate
 @param center The center used to define the circle
 @param radius The radius used to define the circle
 @param bufferZoneWidth The buffer zone width, measured in meters. It enlarges the radius of the circle by this amount. Negative values make the circle smaller.
 @return (double) The distance, in meters, to the circle, taking into account the buffer zone. The distance is positive for coordinates outside the circle, and negative for coordinates within the circle. Will return NaN if buffer zone width is negative and the absolute value is greater than the circle's radius.
 */
+ (double)getDistanceFromCoordinate:(IBMPosition*)coordinate toCircleWithCenter:(IBMPosition*)center radius:(double)radius withBufferZoneWidth:(double)bufferZoneWidth;
/**
 Determines whether a coordinate lies within a circle. Equivalent to calling isCoordinate:insideCircleWithCenter:radius:withBufferZoneWidth:withConfidenceLevel: with a `bufferZoneWidth` of `0` and a `confidenceLevel` of IBMConfidenceLevel#LOW.
 
 @param coordinate The coordinate to test
 @param center The center used to define the circle
 @param radius The radius used to define the circle
 @return (BOOL) `YES` is returned if the coordinate is within the circle.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate insideCircleWithCenter:(IBMPosition *)center radius:(double)radius;
/**
 Determines whether a coordinate lies within a circle, taking into account the buffer zone and confidence level.
 
 @param coordinate The coordinate to test
 @param center The center used to define the circle
 @param radius The radius used to define the circle
 @param bufferZoneWidth The buffer zone width is measured in meters. It enlarges the radius of the circle by this amount. Negative values make the circle smaller.
 @param confidenceLevel The level of confidence indicates how accuracy is taken into account.
 @return (BOOL) `YES` is returned if the coordinate lies inside the circle, at the given level of confidence. The dimensions of the circle used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition *)coordinate insideCircleWithCenter:(IBMPosition *)center radius:(double)radius withBufferZoneWidth:(double)bufferZoneWidth withConfidenceLevel:(IBMConfidenceLevel)confidenceLevel;
/**
 Determines whether a coordinate lies outside a circle. Equivalent to calling isCoordinate:outsideCircleWithCenter:radius:withBufferZoneWidth:withConfidenceLevel: with a `bufferZoneWidth` of `0` and a `confidenceLevel` of IBMConfidenceLevel#LOW.
 
 @param coordinate The coordinate to test
 @param center The center used to define the circle
 @param radius The radius used to define the circle
 @return (BOOL) `YES` is returned if the coordinate is outside the circle.
 */
+ (BOOL)isCoordinate:(IBMPosition *)coordinate outsideCircleWithCenter:(IBMPosition *)center radius:(double)radius;
/**
 Determines whether a coordinate lies outside a circle, taking into account the buffer zone and confidence level.
 
 @param coordinate The coordinate to test
 @param center The center used to define the circle
 @param radius The radius used to define the circle
 @param bufferZoneWidth The buffer zone width is measured in meters. It enlarges the radius of the circle by this amount. Negative values make the circle smaller.
 @param confidenceLevel The level of confidence indicates how accuracy is taken into account.
 @return (BOOL) `YES` is returned if the coordinate lies outside the circle, at the given level of confidence. The dimensions of the circle used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition *)coordinate outsideCircleWithCenter:(IBMPosition *)center radius:(double)radius withBufferZoneWidth:(double)bufferZoneWidth withConfidenceLevel:(IBMConfidenceLevel)confidenceLevel;
/**
 Calculates the distance of a coordinate from a polygon. Equivalent to calling getDistanceFromCoordinate:toPolygon:withBufferZoneWidth: with a `0` as the `bufferZoneWidth` parameter.
 
 @param coordinate The starting coordinate
 @param polygon The polygon used when calculating distance
 @return The distance, in meters, to the polygon. The distance is positive for coordinates outside the polygon, and negative for coordinates within the polygon.
 */
+ (double)getDistanceFromCoordinate:(IBMPosition*)coordinate toPolygon:(IBMPolygon*)polygon;
/**
 Calculates the distance of the coordinate from the polygon, taking into account the buffer zone.
 
 @param coordinate The starting coordinate
 @param polygon The polygon used when calculating distance
 @param bufferZoneWidth The buffer zone width is measured in meters. It increases the size of the polygon in all directions by this amount. Negative values decrease the polygon's size.
 @return The distance, in meters, to the polygon, taking into account the buffer zone. The distance is positive for coordinates outside the polygon, and negative for coordinates within the polygon.
 */
+ (double) getDistanceToPolygon:(IBMPolygon *)polygon fromCoordinate:(IBMPosition *)coordinate withBufferZoneWidth: (double)bufferZoneWidth;
/**
 Determines whether a coordinate lies within a polygon. Equivalent to calling isCoordinate:insidePolygon:withBufferZoneWidth:withConfidenceLevel: with a `bufferZoneWidth` of `0` and a `confidenceLevel` of IBMConfidenceLevel#LOW.
 
 @param coordinate The starting coordinate
 @param polygon The polygon used to test the coordinate against
 @return (BOOL) Returns `YES` if the coordinate is within the polygon.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate insidePolygon:(IBMPolygon*)polygon;
/**
 Determines whether a coordinate lies within a polygon, taking into account the buffer zone and confidence level.
 
 @param coordinate The starting coordinate
 @param polygon The polygon used to test the coordinate against
 @param bufferZoneWidth The buffer zone width is measured in meters. It increases the size of the polygon in all directions by this amount. Negative values decrease the polygon's size.
 @param confidenceLevel The level of confidence indicates how accuracy is taken into account.
 @return (BOOL) Returns `YES` if the coordinate lies inside the polygon, at the given level of confidence. The dimensions of the polygon used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate insidePolygon:(IBMPolygon*)polygon withBufferZoneWidth:(double)bufferZoneWidth withConfidenceLevel:(IBMConfidenceLevel)confidenceLevel;
/**
 Determines whether a coordinate lies within a polygon. Equivalent to calling isCoordinate:outsidePolygon:withBufferZoneWidth:withConfidenceLevel: with a `bufferZoneWidth` of `0` and a `confidenceLevel` of IBMConfidenceLevel#LOW.
 
 @param coordinate The starting coordinate
 @param polygon The polygon used to test the coordinate against
 @return (BOOL) Returns `YES` if the coordinate is outside the polygon.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate outsidePolygon:(IBMPolygon*)polygon;
/**
 Determines whether a coordinate lies within a polygon, taking into account the buffer zone and confidence level.
 
 @param coordinate The starting coordinate
 @param polygon The polygon used to test the coordinate against
 @param bufferZoneWidth The buffer zone width is measured in meters. It increases the size of the polygon in all directions by this amount. Negative values decrease the polygon's size.
 @param confidenceLevel The level of confidence indicates how accuracy is taken into account.
 @return (BOOL) Returns `YES` if the coordinate lies outside the polygon, at the given level of confidence. The dimensions of the polygon used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate outsidePolygon:(IBMPolygon*)polygon withBufferZoneWidth:(double)bufferZoneWidth withConfidenceLevel:(IBMConfidenceLevel)confidenceLevel;
/**
 Checks if the location is within the area taking into account the buffer zone and confidence level.
 
 @param coordinate The starting coordinate
 @param area The id<IBMArea> object to test the coordinate against
 @param bufferZoneWidth The buffer zone width is measured in meters. It increases the size of the area in all directions by this amount. Negative values decrease the area's size.
 @param confidenceLevel The level of confidence indicates how accuracy is taken into account.
 @return (BOOL) Returns `YES` if the coordinate lies inside the area, at the given level of confidence. The dimensions of the area used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate insideArea:(id<IBMArea>)area withBufferZoneWidth:(double)bufferZoneWidth withConfidenceLevel:(IBMConfidenceLevel)confidenceLevel;
/**
 Returns a boolean value based on whether a coordinate lies within an area. Equivalent to calling isCoordinate:insideArea:withBufferZoneWidth:withConfidenceLevel: with a `bufferZoneWidth` of `0` and a `confidenceLevel` of IBMConfidenceLevel#LOW.
 
 @param coordinate The starting coordinate
 @param area The id<IBMArea> object to test the coordinate against
 @return (BOOL) Returns `YES` if the coordinate lies inside the area, at the given level of confidence. The dimensions of the area used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate insideArea:(id<IBMArea>)area;
/**
 Returns a boolean value based on whether a coordinate lies outside an area, taking into account the buffer zone and confidence level.
 
 @param coordinate The coordinate to check
 @param area The id<IBMArea> object to check the coordinate against
 @param bufferZoneWidth The buffer zone width is measured in meters. It increases the size of the area in all directions by this amount. Negative values decrease the area's size.
 @param confidenceLevel The level of confidence indicates how accuracy is taken into account.
 @return (BOOL) Returns `YES` if the coordinate lies outside the area, at the given level of confidence. The dimensions of the area used in this check incorporate any changes specified for the <b><code>bufferZoneWidth</code></b> parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate outsideArea:(id<IBMArea>)area withBufferZoneWidth:(double)bufferZoneWidth withConfidenceLevel:(IBMConfidenceLevel)confidenceLevel;
/**
 Returns a boolean value based on whether a coordinate lies within an area. Equivalent to calling isCoordinate:outsideArea:withBufferZoneWidth:withConfidenceLevel: with a `bufferZoneWidth` of `0` and a `confidenceLevel` of IBMConfidenceLevel#LOW.

 @param coordinate The starting coordinate
 @param area The id<IBMArea> object to test the coordinate against
 @return (BOOL) Returns `YES` if the coordinate lies outside the area, at the given level of confidence. The dimensions of the area used in this check incorporate any changes specified for the **`bufferZoneWidth`** parameter.
 */
+ (BOOL)isCoordinate:(IBMPosition*)coordinate outsideArea:(id<IBMArea>)area;
/**
 Calculates the distance of the coordinate from the area. Equivalent to calling getDistanceFromCoordinate:toArea:withBufferZoneWidth: with a `0` as the `bufferZoneWidth` parameter.
 
 @param coordinate The coordinate to measure distance to
 @param area The area to measure distance from
 @return the distance in meters to the area. The distance is positive for coordinates outside the area and negative for coordinates inside the area.
 */
+ (double)getDistanceFromCoordinate:(IBMPosition*)coordinate toArea:(id<IBMArea>)area;
/**
 Calculates the distance of the coordinate from the area, taking into account the buffer zone.
 
 @param coordinate The coordinate to measure distance from
 @param area The area to measure distance to
 @param bufferZoneWidth The buffer zone width is measured in meters. It increases the size of the area in all directions by this amount. Negative values decrease the area's size.
 @return The distance, in meters, to the polygon, taking into account the buffer zone. The distance is positive for coordinates outside the area, and negative for coordinates within the area.
 */
+ (double)getDistanceFromCoordinate:(IBMPosition*)coordinate toArea:(id<IBMArea>)area withBufferZoneWidth:(double)bufferZoneWidth;

@end

