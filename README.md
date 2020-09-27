# neo4j-with-seed-docker

Neo4J GraphDB Dockerized with support of seeding the database with cyphers. You can quickly instantiate the database with the graph
you need!

# Setup

* Provide all the `*.cql` files under the volume `/cyphers`
  * Example is in the file `cypher_query.cql`
* Wrapper will execute Neo4J in the background and seed all the cyphers in the dir.

> NOTE: Inspect our `docker-compose.yaml` for details

# Seed

* A file with any name with extension `.cql`
* Contents are cypher queries, for instance `cypher_query.cql` below:

```cql
CREATE (facebook:Company {name:'Facebook'})

CREATE (clement:Candidate {name:'Clement'})
CREATE (antoine:Candidate {name:'Antoine'})
CREATE (simon:Candidate {name:'Simon'})
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
 ---> ec5aad0df83e
Step 3/3 : ENTRYPOINT ["./wrapper.sh"]
 ---> Running in f8384e63061b
Removing intermediate container f8384e63061b
 ---> 6d03819be228

Successfully built 6d03819be228
Successfully tagged marcellodesales/neo4j-with-cql-seed:latest
Recreating neo4j-with-wrapper-docker_neo4j_1 ... done
Attaching to neo4j-with-wrapper-docker_neo4j_1
$ docker-compose up --build
Recreating neo4j-with-wrapper-docker_neo4j_1 ... done
Attaching to neo4j-with-wrapper-docker_neo4j_1
neo4j_1  | 2020-09-27 15:56:54:763+0000 INFO  Wrapper: Waiting until neo4j stats at :7474 ...
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
neo4j_1  | 2020-09-27 15:56:55.772+0000 INFO  Starting...
neo4j_1  | 2020-09-27 15:56:57.444+0000 INFO  ======== Neo4j 4.1.2 ========
neo4j_1  | 2020-09-27 15:56:58.408+0000 INFO  Performing postInitialization step for component 'security-users' with version 2 and status CURRENT
neo4j_1  | 2020-09-27 15:56:58.408+0000 INFO  Updating the initial password in component 'security-users'
neo4j_1  | 2020-09-27 15:56:59.928+0000 INFO  Bolt enabled on 0.0.0.0:7687.
neo4j_1  | 2020-09-27 15:57:00.817+0000 INFO  Remote interface available at http://localhost:7474/
neo4j_1  | 2020-09-27 15:57:00.818+0000 INFO  Started.
neo4j_1  | 2020-09-27 15:57:01:916+0000 INFO  Wrapper: Deleting all relations
neo4j_1  | 2020-09-27 15:57:04:688+0000 INFO  Wrapper: Wrapper: Loading cyphers from '/cyphers'
neo4j_1  | 2020-09-27 15:57:04:690+0000 INFO  Wrapper: Running cypher /cyphers/interviews.cql
neo4j_1  | 2020-09-27 15:57:06:186+0000 INFO  Wrapper: Finished loading all cyphers from '/cyphers'
neo4j_1  | 2020-09-27 15:57:07:279+0000 INFO  Wrapper: Wrapper: Changes count 17
neo4j_1  | /docker-entrypoint.sh neo4j
```

# Browse Neo4J

* Go to http://localhost:7474/browse after it has loaded all.

![neo4j-cyphers-loaded](https://user-images.githubusercontent.com/131457/94336227-d6703f80-ffb7-11ea-891b-fc42c7750c28.png)
