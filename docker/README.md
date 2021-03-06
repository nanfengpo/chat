# Using Docker to run nanfengpo

All images are available at https://hub.docker.com/r/nanfengpo/

1. [Install Docker](https://docs.docker.com/install/) 1.8 or above. The provided dockerfiles are dependent on [Docker networking](https://docs.docker.com/network/) which may not work with the older Docker.

2. Create a bridge network. It's used to connect nanfengpo container with the database container.
	```
	$ docker network create nanfengpo-net
	```
	
3. Decide which database backend you want to use: RethinkDB or MySQL. Run the selected database container, attaching it to `nanfengpo-net` network:

	1. **RethinkDB**: If you've decided to use RethinkDB backend, run the official RethinkDB Docker container:
	```
	$ docker run --name rethinkdb --network nanfengpo-net -d rethinkdb:2.3
	```
	See [instructions](https://hub.docker.com/_/rethinkdb/) for more options.
	
	2. **MySQL**: If you've decided to use MySQL backend, run the official MySQL Docker container:
	```
	$ docker run --name mysql --network nanfengpo-net --env MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql:5.7
	```
	See [instructions](https://hub.docker.com/_/mysql/) for more options.
	
	The name `rethinkdb` or `mysql` in the `--name` assignment is important. It's used by other containers as a database's host name.

4. Run the nanfengpo container for the appropriate database:

	1. **RethinkDB**: 
	```
	$ docker run -p 6060:18080 -d --name nanfengpo-srv --network nanfengpo-net nanfengpo/nanfengpo-rethinkdb:latest
	```
	
	2. **MySQL**:
	```
	$ docker run -p 6060:18080 -d --name nanfengpo-srv --network nanfengpo-net nanfengpo/nanfengpo-mysql:latest
	```
		
	The port mapping `-p 6060:18080` tells Docker to map container's port 18080 to host's port 6060 making server accessible at http://localhost:6060/. The container will initialize the database with test data on the first run. 

5. Test the installation by pointing your browser to [http://localhost:6060/](http://localhost:6060/).

## Optional

### Reset data in the database

If you want to reset the data in the database, shut down the nanfengpo container and remove it:
```
$ docker stop nanfengpo-srv && docker rm nanfengpo-srv
```
then repeat step 4 adding `--env RESET_DB=true`.


### Run the chatbot

See [instructions](../chatbot/).

