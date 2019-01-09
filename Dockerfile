FROM binhnv/hadoop-base:1.0.3
MAINTAINER "Binh Van Nguyen<binhnv80@gmail.com>"

ENV HIVE_VERSION="1.2.1" \
    HIVE_USER="hive" \
    HIVE_HOME="${MY_APP_DIR}/hive" \
    HIVE_LOG_DIR="${MY_APP_LOG_DIR}/hive" \
    HIVE_MS_DB_HOST="mysql" \
    HIVE_MS_DB_PORT="3306" \
    HIVE_MS_DB_USERNAME="root" \
    HIVE_MS_DB_PASSWORD="root" \
    HIVE_MS_DB="hive_metastore" \
    HIVE_MS_DRIVER_NAME="com.mysql.jdbc.Driver" \
    MYSQL_CONNECTOR_JAR="/usr/share/java/mysql-connector-java.jar"

ENV PATH="${PATH}:${HIVE_HOME}/bin" \
    HADOOP_HOME="${HADOOP_COMMON_HOME}" \
    HIVE_CONF_DIR="${HIVE_HOME}/conf" \
    HIVE_MS_CONNECTION="jdbc:mysql://${HIVE_MS_DB_HOST}:${HIVE_MS_DB_PORT}/${HIVE_MS_DB}?createDatabaseIfNotExist=true"

COPY scripts/build /my_build
RUN /my_build/install.sh && rm -rf /my_build

COPY templates ${MY_TEMPLATE_DIR}
