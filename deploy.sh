#!/bin/bash

COFF='\033[0m'
CBLACK='\033[0;30m'
CRED='\033[0;31m'
CGREEN='\033[0;32m'
CYELLOW='\033[0;33m'
CBLUE='\033[0;34m'
CPURPLE='\033[0;35m'
CCYAN='\033[0;36m'
CWHITE='\033[0;37m'
CGRAY='\033[1;30m'
SED_PATTERN="s/^/$(tput setaf 0)$(tput bold)Traefiked: $(tput sgr0) /"
function printf() { builtin printf "${CGRAY}Traefiked: ${COFF} $1"; }

########################
#### CORE
########################

main() {
    STACK_NAME=$1
    STACK_FILE="${PWD}/$STACK_NAME/docker-stack.yml"
    ENV_FILE="${PWD}/$STACK_NAME/.env"

    if [ ! -f $STACK_FILE ]; then
        printf "${CRED}Stack not found in directory${COFF}\n" >&2
        return 1
    fi

    printf "${CGREEN}Checking if overlay network exists...${COFF}\n"
    if [ ! "$(docker network ls | grep traefiked)" ]; then
        printf "${CGREEN}Creating network for proxy...${COFF}\n"
        docker network create --driver overlay --attachable traefiked 2>&1 | sed "${SED_PATTERN}"
    else
        printf "${CGRAY}Network already exists${COFF}\n"
    fi

    (
        [ -f $ENV_FILE ] && export $(sed '/^#/d' $ENV_FILE)
        printf "${CGREEN}Deploying stack...${COFF}\n"
        docker stack deploy --compose-file $STACK_FILE $STACK_NAME 2>&1 | sed "${SED_PATTERN}"
    )
}

main $1