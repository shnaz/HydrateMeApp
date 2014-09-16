//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMLocationConfiguration.h
//  IBMLocation iOS SDK

@class IBMGeoAcquisitionPolicy;

/**
 The configuration for on-going acquisition, including the acquisition policy, triggers, and 
 failure callbacks for handling acquisition errors.
 
 The IBMLocationConfiguration class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@interface IBMLocationConfiguration : NSObject <NSCopying>

/**
 * The geo acquisition policy associated with this configuration
 */
@property (nonatomic) IBMGeoAcquisitionPolicy* geoAcquisitionPolicy;
/**
 * The geo triggers to be evaluated during ongoing acquisition.
 */
@property (nonatomic) NSMutableDictionary *geoTriggers;
/**
 * An array of the failure callbacks associated with this configuration. During on-going acquisition, each failure callback will be called when errors occur.
 */
@property (nonatomic) NSMutableArray* failureCallbacks;

@end

