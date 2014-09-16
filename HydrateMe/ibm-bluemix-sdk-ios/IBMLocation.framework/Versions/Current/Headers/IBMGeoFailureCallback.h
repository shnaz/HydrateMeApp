//-------------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// XXXX-XXX (C) Copyright IBM Corp. 2013. All Rights Reserved.
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------------------
//
//  IBMGeoFailureCallback.h
//  IBMLocation iOS SDK

#import "IBMAcquisitionFailureCallback.h"
@class IBMGeoError;

/**
 A callback for when an error occurs in Geo acquisition
 
 The IBMGeoFailureCallback class is a provisional API.  APIs that are marked provisional are evolving and might change or be removed in future releases.
 */
@protocol IBMGeoFailureCallback <IBMAcquisitionFailureCallback>

/**
 The method will be executed when an error occurs during acquisition.
 
 @param errorObject the error that occurred.
 */
- (void) execute : (IBMGeoError *) errorObject ;

@end

