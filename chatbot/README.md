# nanfengpo Chatbot Example

This is a rudimentary chatbot for nanfengpo using [gRPC API](../pbx/). It's written in Python as a demonstration
that the API is language-independent.

The chat bot subscribes to events stream using Plugin API and logs in as 'Tino the Chatbot' user. The event stream API is used to listen for new accounts. When a new account is created, the bot initiates a p2p topic with the new user. Then it listens for messages sent to the topic and responds to each with a random quote from `quotes.txt` file.

Generated files are provided for convenience in a [separate folder](../pbx). You may re-generate them if needed:
```
python -m grpc_tools.protoc -I../pbx --python_out=. --grpc_python_out=. ../pbx/model.proto
```

## Installing and running

### Using Docker

**Warning!** The chatbot image is almost 750MB: the basic Python 3 docker image is nearly 690MB, gRPC adds another 60MB.

1. Follow [instructions](../docker/README.md) to build and run dockerized nanfengpo chat server up to an including _step 3_.
	
2. In _step 4_ run the server adding `--env PLUGIN_PYTHON_CHAT_BOT_ENABLED=true` and `--volume botdata:/botdata` to the command line:
	1. **RethinkDB**:
	```
	$ docker run -p 6060:18080 -d --name nanfengpo-srv --env PLUGIN_PYTHON_CHAT_BOT_ENABLED=true --volume botdata:/botdata --network nanfengpo-net nanfengpo/nanfengpo-rethink:latest
	```
	1. **MySQL**:
	```
	$ docker run -p 6060:18080 -d --name nanfengpo-srv --env PLUGIN_PYTHON_CHAT_BOT_ENABLED=true --volume botdata:/botdata --network nanfengpo-net nanfengpo/nanfengpo-mysql:latest
	```
	
3. Run the chatbot
	```
	$ docker run -d --name tino-chatbot --network nanfengpo-net --volume botdata:/botdata nanfengpo/chatbot:latest
	```
	
4. Test that the bot is functional by pointing your browser to http://localhost:6060/x/, login and talk to user `Tino`. The user should respond to every message with a random quote.

	
### Building from Source

Make sure [python](https://www.python.org/) 2.7 or 3.4 or higher is installed. Make sure [pip](https://pip.pypa.io/en/stable/installing/) 9.0.1 or higher is installed. If you are using python 2.7 install `futures`:
```
pip install futures
```

Follow instructions to [install grpc](https://grpc.io/docs/quickstart/python.html#install-grpc). The package is called `grpcio` (*not* `grpc`!):
```
pip install grpcio
```

Start the [nanfengpo server](../INSTALL.md) first. Then start the chatbot with credentials of the user you want to be your bot, `alice` in this example:
```
python chatbot.py --login-basic=alice:alice123
```
If you want to run the bot in the background, start it as
```
nohup python chatbot.py --login-basic=alice:alice123 &
```
Run `python chatbot.py -h` for more options.

If you are using python 2.7, keep in mind that `condition.wait()` [is forever buggy](https://bugs.python.org/issue8844). As a consequence of this bug the bot cannot be terminated with a SIGINT. It has to be stopped with a SIGKILL.  

You can use cookie file to store credentials. Sample cookie files are provided as `basic-cookie.sample` and `token-cookie.sample`. Once authenticated the bot will attempt to store the token in the cookie file, `.tn-cookie` by default. If you have a cookie file with the default name, you can run the bot with no parameters:
```
python chatbot.py
```

Quotes are read from `quotes.txt` by default. The file is plain text with one quote per line.
