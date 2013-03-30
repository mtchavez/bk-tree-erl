all: depend compile

depend:
	rebar get-deps

compile:
	rebar compile

test: compile
	rebar eunit

clean:
	rebar clean

console: all
	cd ./src && erl
