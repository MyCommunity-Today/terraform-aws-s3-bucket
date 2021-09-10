#!/bin/bash -e

BASEDIR="$( cd "$( dirname "$0" )" && pwd )"
echo "Current Script Directory is : $BASEDIR"

#############
# FUNCTIONS
#############
terraform_plan () {
    EXAMPLE_DIR=$1
    pushd $EXAMPLE_DIR
    pwd
    terraform init 
    terraform validate -no-color
    terraform plan
    popd
}

run_examples () {
    if [ -d examples ]
        then 
        EXAMPLES=$(find ./examples -mindepth 1 -maxdepth 1 -type d -exec echo {} \;)
        if [ -z $EXAMPLES ]
            then 
            terraform_plan ./examples
        else
            for EXAMPLE in $EXAMPLES
            do 
                echo "Skipping anything which doesn't have a tf file "
                TF_EXIST=$(find $EXAMPLE  -type f -name "*.tf" | wc -l)
                if [ $TF_EXIST -gt 0 ]; then
                    terraform_plan $EXAMPLE
                fi
            done
        fi
    else 
        echo "Examples not written yet for $SUB_MODULE" 
    fi
}

########################
# SUB-MODULES EXAMPLES
########################
echo "Check if there are sub-modules aviable"
if [ -d modules ]
then 
    echo "Submodules exist in this repository Processing them first"
    SUBMODULES=$(find ./modules -mindepth 1 -maxdepth 1 -type d -exec echo {} \;)
    echo "Submodules to be processed => $SUBMODULES"

    echo "Processing Sub-Module Examples"
    for SUB_MODULE in $SUBMODULES
    do 
    echo "Processing $SUB_MODULE"
    pushd $SUB_MODULE
    echo "Running in Directory => $pwd"
    run_examples
    popd
    echo "Switched back to Directory =>  $pwd"
    done 
fi

echo "Processing Module Examples"
run_examples