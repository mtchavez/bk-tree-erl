all: depend compile

depend:
	rebar3 get-deps

compile:
	rebar3 compile

test: compile
	rebar3 eunit

clean:
	rebar3 clean

console: all
	cd ./src && erl
