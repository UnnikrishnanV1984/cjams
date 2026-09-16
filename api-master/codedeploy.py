# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file
# except in compliance with the License. A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on an "AS IS"
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the
from __future__ import print_function
import os
import sys
from time import strftime, sleep
import boto3
from botocore.exceptions import ClientError

VERSION_LABEL = strftime("%Y%m%d%H%M%S")
BUCKET_KEY = os.getenv('APPLICATION_NAME') + '/' + VERSION_LABEL +'-'+os.getenv('APP_PACKAGE_NAME')

def upload_to_s3(artifact):
    """
    Uploads an artifact to Amazon S3
    """
    try:
        client = boto3.client('s3')
    except ClientError as err:
        print("Failed to create boto3 client.\n" + str(err))
        return False
    try:
        client.put_object(
            Body=open(artifact, 'rb'),
            Bucket=os.getenv('S3_BUCKET'),
            Key=BUCKET_KEY
        )
    except ClientError as err:
        print("Failed to upload artifact to S3.\n" + str(err))
        return False
    except IOError as err:
        print("Failed to access cjams-api.tar.gz in this directory.\n" + str(err))
        return False
    return True

def deploy_new_revision():
    """
    Deploy a new application revision to AWS CodeDeploy Deployment Group
    """
    try:
        client = boto3.client('codedeploy')
    except ClientError as err:
        print("Failed to create boto3 client.\n" + str(err))
        return False

    try:
        response = client.create_deployment(
            applicationName=str(os.getenv('APPLICATION_NAME')),
            deploymentGroupName=str(os.getenv('DEPLOYMENT_GROUP_NAME')),
            revision={
                'revisionType': 'S3',
                's3Location': {
                    'bucket': os.getenv('S3_BUCKET'),
                    'key': BUCKET_KEY,
                    'bundleType': 'tgz'
                }
            },
            deploymentConfigName=str(os.getenv('DEPLOYMENT_CONFIG')),
            description='New deployment from BitBucket',
            ignoreApplicationStopFailures=True
        )
    except ClientError as err:
        print("Failed to deploy application revision.\n" + str(err))
        return False     
           
    """
    Wait for deployment to complete
    """
    while 1:
        try:
            deployment_response = client.get_deployment(
                deploymentId=str(response['deploymentId'])
            )
            deployment_status=deployment_response['deploymentInfo']['status']
            if deployment_status == 'Succeeded':
                print ("Deployment Succeeded")
                return True
            elif (deployment_status == 'Failed') or (deployment_status == 'Stopped') :
                print ("Deployment Failed")
                return False
            elif (deployment_status == 'InProgress') or (deployment_status == 'Queued') or (deployment_status == 'Created'):
                continue
        except ClientError as err:
            print("Failed to deploy application revision.\n" + str(err))
            return False      
    return True

def main():
    if not upload_to_s3('cjams-api.tar.gz'):
        sys.exit(1)
    if not deploy_new_revision():
        sys.exit(1)

if __name__ == "__main__":
    main()