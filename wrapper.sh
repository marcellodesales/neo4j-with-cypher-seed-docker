#!/bin/bash

# Adapted from https://github.com/neo4j/docker-neo4j/issues/166#issuecomment-486890785
# Alpine is not supported anymore, so this is newer
# Refactoring: Marcello.deSales+github@gmail.com

# export NEO4J_USERNAME=$NEO4J_USERNAME
# export NEO4J_PASSWORD=$NEO4J_PASSWORD

# turn on bash's job control
# https://stackoverflow.com/questions/11821378/what-does-bashno-job-control-in-this-shell-mean/46829294#46829294
set -m

# Start the primary process and put it in the background
/docker-entrypoint.sh neo4j &

# Log the info with the same format as NEO4J outputs
log_info() {
  # https://www.howtogeek.com/410442/how-to-display-the-date-and-time-in-the-linux-terminal-and-use-it-in-bash-scripts/
  printf '%s %s\n' "$(date -u +"%Y-%m-%d %H:%M:%S:%3N%z") INFO  $1"
  return
}

# wait for Neo4j
log_info "Wrapper: Waiting until neo4j stats at :7474 ..."
wget --quiet --tries=10 --waitretry=2 -O /dev/null http://localhost:7474

log_info  "Wrapper: Deleting all relations"
cypher-shell --format plain "MATCH (n) DETACH DELETE n"

if [ -d "/cyphers" ]; then
  log_info  "Wrapper: Loading cyphers from '/cyphers'"
  for f in /cyphers/*.cql; do
      log_info "Wrapper: Running cypher ${f}"
      cypher-shell --file $f
  done
  log_info  "Wrapper: Finished loading all cyphers from '/cyphers'"
fi

TOTAL_CHANGES=$(cypher-shell --format plain "MATCH (n) RETURN count(n) AS count")
# https://stackoverflow.com/questions/15520339/how-to-remove-carriage-return-and-newline-from-a-variable-in-shell-script/15520508#15520508
log_info "Wrapper: Changes $(echo ${TOTAL_CHANGES} | sed -e 's/[\r\n]//g')"

# now we bring the primary process back into the foreground
# and leave it there
fg %1
