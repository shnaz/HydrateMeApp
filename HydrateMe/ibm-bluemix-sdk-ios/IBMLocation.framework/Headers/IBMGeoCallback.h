//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoCallback.h
//  IBMLocation iOS SDK

#import "IBMAcquisitionCallback.h"
@class IBMPosition;

/**
 A callback for when a Geo position is acquired.
 
 The IBMGeoCallback class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@protocol IBMGeoCallback <IBMAcquisitionCallback>

/**
 This method will be executed when a Geo position is acquired.
 
 @param pos The Geo position acquired.
 */
- (void) execute : (IBMPosition*) pos ;

@end
