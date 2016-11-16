#!/usr/bin/env bash

set -e

g_hive_user="${HIVE_USER}"
g_hive_home="${HIVE_HOME}"
g_log_dir="${HIVE_LOG_DIR}"
g_mysql_connector_jar=${MYSQL_CONNECTOR_JAR}
g_hive_url="http://www.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz"

function install_dependencies {
    apt-get update
    apt-get install -y --no-install-recommends \
        mysql-client \
        libmysql-java
}

function install_package {
    install_dependencies

    mkdir -p ${g_hive_home}
    curl -L ${g_hive_url} | tar -xzC ${g_hive_home} --strip-components=1
    chown -R ${g_hive_user} ${g_hive_home}

    ln -s ${g_mysql_connector_jar} ${g_hive_home}/lib/mysql-connector-java.jar
}

function create_user {
    # create user and his home directory
    useradd -m ${g_hive_user}
}

function cleanup {
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}

function main {
    create_user
    install_package
    cleanup
    
    mkdir -p ${g_log_dir}
    chown ${g_hive_user} ${g_log_dir}
}

main "$@"
