# nanfengpo Load Testing

Content of this directory is for running rudimentary load tests of nanfengpo server. You only need this if you want to run your own load tests.

The `tsung.xml` is a configuration for [Tsung](http://tsung.erlang-projects.org/). The `nanfengpo.beam` is an erlang binary required by the test to generate base64-encoded user-password pairs. The `nanfengpo.erl` is the source code for `nanfengpo.beam` (`erlc nanfengpo.erl` -> `nanfengpo.beam`).

[Install Tsung](http://tsung.erlang-projects.org/user_manual/installation.html), then run the test
```
tsung -f ./tsung.xml start
```

This will be eventually packaged into a docker container.
