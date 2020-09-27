FROM neo4j:latest

#COPY ./files/*.jar /var/lib/neo4j/plugins/

#RUN chmod 755 /cypher-runner/cypher-runner.sh && \
#    chmod 755 /docker-entrypoint.sh && \
#    echo 'dbms.security.procedures.unrestricted=algo.*,apoc.*' >> /var/lib/neo4j/conf/neo4j.conf

# https://github.com/neo4j/docker-neo4j/issues/166#issuecomment-486890785
COPY wrapper.sh wrapper.sh

# Where the load the cyphers to seed the database
VOLUME /cyphers

ENTRYPOINT ["./wrapper.sh"]
