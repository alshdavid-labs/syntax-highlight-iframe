#!/bin/bash

set -e

export AWS_DEFAULT_OUTPUT="yaml"
export AWS_PAGER=
export AWS_EC2_METADATA_DISABLED=true

aws s3 rm --recursive s3://alshdavid-web-com-davidalsh-cdn/syntax-highlight-iframe
aws s3 cp --recursive ./dist s3://alshdavid-web-com-davidalsh-cdn/syntax-highlight-iframe
aws cloudfront create-invalidation --distribution-id E2QHY39OWRUCEU --paths /syntax-highlight-iframe\*
