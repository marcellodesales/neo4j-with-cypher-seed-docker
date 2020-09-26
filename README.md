# neo4j-with-wrapper-docker

Neo4J GraphDB Dockerized with support to Wrappers to load provided `*.cql`.

# Setup

* Provide all the `*.cql` files under the volume `/cyphers`
  * Example is in the file `cypher_query.cql`
* Wrapper will execute Neo4J in the background and seed all the cyphers in the dir.

> NOTE: Inspect our `docker-compose.yaml` for details

# Seed

* A file with any name with extension `.cql`
* Contents are cypher queries, for instance `interviews.cql` below:

```cql
CREATE (facebook:Company {name:'Facebook'});

CREATE (clement:Candidate {name:'Clement'});
CREATE (antoine:Candidate {name:'Antoine'});
CREATE (simon:Candidate {name:'Simon'});
...
...
```

# Run Neo4J with Seed

* The execution will start Neo4J in the background and seed all files from the dir `/cyphers`.

```
$ docker-compose up --build
Building neo4j
Step 1/3 : FROM neo4j:latest
 ---> da74cc6bec8a
Step 2/3 : COPY wrapper.sh wrapper.sh
 ---> bb25bb5ebd41
Step 3/3 : ENTRYPOINT ["./wrapper.sh"]
 ---> Running in 781beff70020
Removing intermediate container 781beff70020
 ---> 346abfbe1743

Successfully built 346abfbe1743
Successfully tagged marcellodesales/neo4j:latest
Recreating specialized_storage_neo4j_1 ... done
Attaching to specialized_storage_neo4j_1
neo4j_1  | 2020-09-26 06:08:17:387+0000 INFO  Wrapper: Waiting until neo4j stats at :7474 ...
neo4j_1  | Directories in use:
neo4j_1  |   home:         /var/lib/neo4j
neo4j_1  |   config:       /var/lib/neo4j/conf
neo4j_1  |   logs:         /logs
neo4j_1  |   plugins:      /var/lib/neo4j/plugins
neo4j_1  |   import:       /var/lib/neo4j/import
neo4j_1  |   data:         /var/lib/neo4j/data
neo4j_1  |   certificates: /var/lib/neo4j/certificates
neo4j_1  |   run:          /var/lib/neo4j/run
neo4j_1  | Starting Neo4j.
neo4j_1  | 2020-09-26 06:08:18.743+0000 INFO  Starting...
neo4j_1  | 2020-09-26 06:08:21.201+0000 INFO  ======== Neo4j 4.1.2 ========
neo4j_1  | 2020-09-26 06:08:22.710+0000 INFO  Performing postInitialization step for component 'security-users' with version 2 and status CURRENT
neo4j_1  | 2020-09-26 06:08:22.710+0000 INFO  Updating the initial password in component 'security-users'
neo4j_1  | 2020-09-26 06:08:23.079+0000 INFO  Bolt enabled on 0.0.0.0:7687.
neo4j_1  | 2020-09-26 06:08:24.440+0000 INFO  Remote interface available at http://localhost:7474/
neo4j_1  | 2020-09-26 06:08:24.441+0000 INFO  Started.
neo4j_1  | 2020-09-26 06:08:26:576+0000 INFO  Wrapper: Loading cyphers from '/cyphers'
neo4j_1  | 2020-09-26 06:08:26:577+0000 INFO  Wrapper: Running cypher /cyphers/interviews.cql
neo4j_1  | 2020-09-26 06:08:31:449+0000 INFO  Wrapper: Finished loading all cyphers from '/cyphers'
neo4j_1  | 2020-09-26 06:08:32:986+0000 INFO  Wrapper: Changes count 423
neo4j_1  | /docker-entrypoint.sh neo4j
^CGracefully stopping... (press Ctrl+C again to force)
Stopping specialized_storage_neo4j_1   ...
Killing specialized_storage_neo4j_1    ... done
```

# Browse Neo4J

* Go to http://localhost:7474/browse after it has loaded all.
