#!/bin/bash
basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
databasedir="${basedir}/databases"

POD=$(kubectl get pod -n postgres --no-headers | awk '{print $1}')
PVDIR=$(kubectl exec -n postgres ${POD} -- env | grep POSTGRESQL_VOLUME_DIR | awk -F = '{print $NF}')
PGPASSWORD=$(kubectl exec -n postgres ${POD} -- env | grep POSTGRESQL_PASSWORD | awk -F = '{print $NF}')
PGUSER=$(kubectl exec -n postgres ${POD} -- env | grep POSTGRESQL_USER | awk -F = '{print $NF}')

kubectl exec -n postgres ${POD} -- mkdir ${PVDIR}/import
kubectl cp ${databasedir}/* postgres/${POD}:${PVDIR}/import/

for tar in $(ls ${databasedir} |grep .tar); do
  DB=$(echo ${tar} |sed 's/.tar//')
  DB=$(echo ${DB} | awk '{print tolower($0)}')
  kubectl exec -n postgres ${POD} -- bash -c "export PGUSER=${PGUSER}; \
  export PGPASSWORD=${PGPASSWORD}; \
  pqsl -c 'DROP DATABASE IF EXISTS ${DB};'; \
  psql -c 'CREATE DATABASE ${DB};'; \
  pg_restore -d ${DB} -v ${PVDIR}/import/${tar}"
done